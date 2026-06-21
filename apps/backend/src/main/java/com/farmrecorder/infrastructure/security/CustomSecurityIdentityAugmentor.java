package com.farmrecorder.infrastructure.security;

import io.quarkus.security.identity.AuthenticationRequestContext;
import io.quarkus.security.identity.SecurityIdentity;
import io.quarkus.security.identity.SecurityIdentityAugmentor;
import io.quarkus.security.runtime.QuarkusSecurityIdentity;
import jakarta.enterprise.context.ApplicationScoped;
import io.smallrye.mutiny.Uni;
import org.eclipse.microprofile.jwt.JsonWebToken;
import jakarta.inject.Inject;

@ApplicationScoped
public class CustomSecurityIdentityAugmentor implements SecurityIdentityAugmentor {

    @Inject
    JsonWebToken jwt;

    @Override
    public Uni<SecurityIdentity> augment(SecurityIdentity identity, AuthenticationRequestContext context) {
        if (identity.isAnonymous()) {
            return Uni.createFrom().item(identity);
        }

        return Uni.createFrom().item(() -> {
            QuarkusSecurityIdentity.Builder builder = QuarkusSecurityIdentity.builder(identity);
            
            // Any authenticated Firebase user receives the FARM_WORKER role
            builder.addRole("FARM_WORKER");
            
            // Check if JWT token role claim is ADMIN
            Object roleClaim = jwt.getClaim("role");
            if (roleClaim != null && "ADMIN".equalsIgnoreCase(roleClaim.toString())) {
                builder.addRole("ADMIN");
            }
            
            return builder.build();
        });
    }
}
