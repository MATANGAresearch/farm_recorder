package com.farmrecorder.infrastructure.opensearch;

import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.port.OpenSearchIndexerPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.opensearch.core.IndexRequest;

import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
public class OpenSearchIndexerAdapter implements OpenSearchIndexerPort {

    private static final Logger LOG = Logger.getLogger(OpenSearchIndexerAdapter.class);
    private static final String INDEX_NAME = "farm-activities";

    private final OpenSearchClient openSearchClient;

    @Inject
    public OpenSearchIndexerAdapter(OpenSearchClient openSearchClient) {
        this.openSearchClient = openSearchClient;
    }

    @Override
    public void indexActivity(ActivityLog activityLog) {
        try {
            Map<String, Object> document = new HashMap<>();
            document.put("activityId", activityLog.id().toString());
            document.put("userId", activityLog.userId());
            document.put("locationId", activityLog.locationId() != null ? activityLog.locationId().toString() : null);
            document.put("taskId", activityLog.taskId() != null ? activityLog.taskId().toString() : null);
            document.put("activityType", activityLog.type().name());
            document.put("timestamp", activityLog.timestamp().toString());
            document.put("notes", activityLog.notes());
            
            if (activityLog.gpsLat() != null && activityLog.gpsLng() != null) {
                Map<String, Double> gps = new HashMap<>();
                gps.put("lat", activityLog.gpsLat());
                gps.put("lon", activityLog.gpsLng());
                document.put("gps", gps);
            }

            IndexRequest<Map<String, Object>> request = IndexRequest.of(b -> b
                    .index(INDEX_NAME)
                    .id(activityLog.id().toString())
                    .document(document)
            );

            openSearchClient.index(request);
            LOG.infof("Successfully indexed activity %s in OpenSearch", activityLog.id());
        } catch (Exception e) {
            // Log error but do not throw, to avoid breaking the main transaction if OpenSearch is temporarily down
            LOG.errorf(e, "Failed to index activity %s in OpenSearch", activityLog.id());
        }
    }
}
