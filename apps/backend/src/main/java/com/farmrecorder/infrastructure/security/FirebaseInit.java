package com.farmrecorder.infrastructure.security;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@ApplicationScoped
public class FirebaseInit {

    @ConfigProperty(name = "farmrecorder.firebase.credentials-json", defaultValue = "")
    String credentialsJson;

    void onStart(@Observes StartupEvent ev) {
        if (credentialsJson == null || credentialsJson.isBlank()) {
            System.out.println("⚠️ Firebase credentials JSON not found in configuration. Promotion endpoints will not function.");
            return;
        }

        try {
            ByteArrayInputStream stream = new ByteArrayInputStream(credentialsJson.getBytes(StandardCharsets.UTF_8));
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(stream))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("✅ Firebase Admin SDK initialized successfully.");
            }
        } catch (IOException e) {
            System.err.println("❌ Failed to initialize Firebase Admin SDK: " + e.getMessage());
        }
    }
}
