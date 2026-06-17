package com.farmrecorder.infrastructure.storage;

import com.farmrecorder.core.util.IdGenerator;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Configuration;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.PresignedPutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.model.PutObjectPresignRequest;

import java.net.URI;
import java.time.Duration;

@ApplicationScoped
public class S3Service {

    private final S3Presigner presigner;
    private static final String BUCKET_NAME = "farm-media";

    @Inject
    public S3Service(
            @ConfigProperty(name = "quarkus.s3.endpoint-override") String endpoint,
            @ConfigProperty(name = "farmrecorder.s3.public-endpoint", defaultValue = "") String publicEndpoint,
            @ConfigProperty(name = "quarkus.s3.aws.credentials.static-provider.access-key-id") String accessKey,
            @ConfigProperty(name = "quarkus.s3.aws.credentials.static-provider.secret-access-key") String secretKey) {

        String finalEndpoint = (publicEndpoint == null || publicEndpoint.trim().isEmpty()) ? endpoint : publicEndpoint;
        this.presigner = S3Presigner.builder()
                .endpointOverride(URI.create(finalEndpoint))
                .region(Region.US_EAST_1)
                .credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials.create(accessKey, secretKey)))
                .serviceConfiguration(S3Configuration.builder().pathStyleAccessEnabled(true).build())
                .build();
    }

    public String generatePresignedUploadUrl(String farmId, String taskId, String fileName, String contentType) {
        // Hierarchical folder structure: farms/{farmId}/tasks/{taskId}/{uuidv7}-{fileName}
        // Using UUIDv7 ensures files are chronologically sortable in S3/MinIO
        String objectKey = String.format("farms/%s/tasks/%s/%s-%s", farmId, taskId, IdGenerator.generate().toString(), fileName);

        PutObjectRequest objectRequest = PutObjectRequest.builder()
                .bucket(BUCKET_NAME)
                .key(objectKey)
                .contentType(contentType)
                .build();

        PutObjectPresignRequest presignRequest = PutObjectPresignRequest.builder()
                .signatureDuration(Duration.ofMinutes(15))
                .putObjectRequest(objectRequest)
                .build();

        PresignedPutObjectRequest presignedRequest = presigner.presignPutObject(presignRequest);
        return presignedRequest.url().toString();
    }

    public String getObjectUrl(String objectKey) {
        // For MinIO with path-style access, construct the URL manually
        return "http://localhost:9000/" + BUCKET_NAME + "/" + objectKey;
    }
}
