package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.HarvestBatchService;
import com.farmrecorder.domain.model.HarvestBatch;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import java.util.UUID;

@Path("/api/v1/harvest-batches")
@Produces(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Harvest Batches", description = "Manage and query harvest batches for traceability and sales")
public class HarvestBatchResource {

    private final HarvestBatchService harvestBatchService;

    @Inject
    public HarvestBatchResource(HarvestBatchService harvestBatchService) {
        this.harvestBatchService = harvestBatchService;
    }

    @GET
    @Path("/available/{productId}")
    @Operation(summary = "Get available batches for a product", description = "Retrieves all harvest batches with remaining quantity > 0 for a specific product")
    @APIResponse(responseCode = "200", description = "List of available harvest batches",
        content = @Content(schema = @Schema(implementation = HarvestBatch.class, type = org.eclipse.microprofile.openapi.annotations.enums.SchemaType.ARRAY)))
    public List<HarvestBatch> getAvailableByProductId(@PathParam("productId") UUID productId) {
        return harvestBatchService.getAvailableByProductId(productId);
    }
}
