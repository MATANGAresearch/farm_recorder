package com.farmrecorder.infrastructure.storage;

import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Configuration;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.HeadBucketRequest;
import software.amazon.awssdk.services.s3.model.NoSuchBucketException;

import java.net.URI;

@ApplicationScoped
public class MinioStartup {

    private static final Logger LOG = Logger.getLogger(MinioStartup.class);
    private static final String BUCKET_NAME = "farm-media";

    private final S3Client s3Client;

    @Inject
    public MinioStartup(
            @ConfigProperty(name = "quarkus.s3.endpoint-override") String endpoint,
            @ConfigProperty(name = "quarkus.s3.aws.credentials.static-provider.access-key-id") String accessKey,
            @ConfigProperty(name = "quarkus.s3.aws.credentials.static-provider.secret-access-key") String secretKey) {
        
        this.s3Client = S3Client.builder()
                .endpointOverride(URI.create(endpoint))
                .region(Region.US_EAST_1)
                .credentialsProvider(StaticCredentialsProvider.create(AwsBasicCredentials.create(accessKey, secretKey)))
                .serviceConfiguration(S3Configuration.builder().pathStyleAccessEnabled(true).build())
                .build();
    }

    void onStart(@Observes StartupEvent ev) {
        try {
            s3Client.headBucket(HeadBucketRequest.builder().bucket(BUCKET_NAME).build());
            LOG.infof("Bucket '%s' already exists.", BUCKET_NAME);
        } catch (NoSuchBucketException e) {
            LOG.infof("Creating bucket '%s'...", BUCKET_NAME);
            s3Client.createBucket(CreateBucketRequest.builder().bucket(BUCKET_NAME).build());
            LOG.infof("Bucket '%s' created successfully.", BUCKET_NAME);
        } catch (Exception e) {
            LOG.errorf(e, "Failed to check or create bucket '%s'", BUCKET_NAME);
        }
    }
}
