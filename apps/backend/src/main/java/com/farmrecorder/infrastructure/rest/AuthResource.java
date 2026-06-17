package com.farmrecorder.infrastructure.rest;

import io.quarkus.oidc.runtime.OidcUtils;
import jakarta.ws.rs.*;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.core.Form;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.Map;

@Path("/api/auth")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Authentication", description = "User authentication via Keycloak")
public class AuthResource {

    @ConfigProperty(name = "quarkus.oidc.auth-server-url")
    String authServerUrl;

    @ConfigProperty(name = "quarkus.oidc.client-id")
    String clientId;

    @ConfigProperty(name = "quarkus.oidc.credentials.secret")
    String clientSecret;

    private final Client client = ClientBuilder.newClient();

    @POST
    @Path("/login")
    @Operation(summary = "Login via Keycloak Direct Grant", description = "Authenticates user and returns a Keycloak JWT token")
    @APIResponse(responseCode = "200", description = "Login successful",
        content = @Content(schema = @Schema(implementation = Map.class)))
    @APIResponse(responseCode = "401", description = "Invalid credentials")
    public Response login(Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        String tokenUrl = authServerUrl + "/protocol/openid-connect/token";

        Form form = new Form()
                .param("grant_type", "password")
                .param("client_id", clientId)
                .param("client_secret", clientSecret)
                .param("username", username)
                .param("password", password);

        try (Response keycloakResponse = client.target(tokenUrl)
                .request(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
                .post(Entity.form(form))) {
            
            if (keycloakResponse.getStatus() == 200) {
                return Response.ok(keycloakResponse.readEntity(String.class)).build();
            } else {
                return Response.status(Response.Status.UNAUTHORIZED)
                        .entity(Map.of("error", "Invalid username or password"))
                        .build();
            }
        }
    }
}
