package com.farmrecorder.infrastructure.rest;

import io.smallrye.common.annotation.Blocking;
import io.smallrye.mutiny.Uni;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.opensearch._types.FieldValue;
import org.opensearch.client.opensearch.core.SearchRequest;
import org.opensearch.client.opensearch.core.SearchResponse;

import java.util.List;
import java.util.Map;

@Path("/api/v1/analytics")
@Produces(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@Blocking
@Tag(name = "Analytics", description = "OpenSearch powered analytics and geo-spatial queries")
public class AnalyticsResource {

    private final OpenSearchClient openSearchClient;

    @Inject
    public AnalyticsResource(OpenSearchClient openSearchClient) {
        this.openSearchClient = openSearchClient;
    }

    @GET
    @Path("/activities")
    @Operation(summary = "Search activities", description = "Search activities with optional full-text notes and geo-bounding box")
    public Uni<Response> searchActivities(
            @QueryParam("notes") String notes,
            @QueryParam("minLat") Double minLat,
            @QueryParam("maxLat") Double maxLat,
            @QueryParam("minLon") Double minLon,
            @QueryParam("maxLon") Double maxLon,
            @QueryParam("size") @DefaultValue("50") Integer size) {

        return Uni.createFrom().item(() -> {
            try {
                SearchRequest.Builder builder = new SearchRequest.Builder()
                        .index("farm-activities")
                        .size(size);

                if (notes != null && !notes.isEmpty()) {
                    builder.query(q -> q.match(m -> m.field("notes").query(FieldValue.of(notes))));
                }

                if (minLat != null && maxLat != null && minLon != null && maxLon != null) {
                    builder.query(q -> q.geoBoundingBox(g -> g
                            .field("gps")
                            .boundingBox(b -> b.coords(c -> c
                                    .top(minLat)
                                    .bottom(maxLat)
                                    .left(minLon)
                                    .right(maxLon)
                            ))
                    ));
                }

                if (notes == null && (minLat == null || maxLat == null || minLon == null || maxLon == null)) {
                    builder.query(q -> q.matchAll(m -> m));
                }

                SearchResponse<Map> response = openSearchClient.search(builder.build(), Map.class);
                
                List<Map> results = response.hits().hits().stream()
                        .map(hit -> hit.source())
                        .toList();

                return Response.ok(Map.of(
                        "total", response.hits().total().value(),
                        "results", results
                )).build();
            } catch (Exception e) {
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                        .entity(Map.of("error", "Failed to search OpenSearch: " + e.getMessage())).build();
            }
        });
    }
}
