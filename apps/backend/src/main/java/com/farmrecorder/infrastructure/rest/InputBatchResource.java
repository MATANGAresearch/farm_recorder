package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.domain.model.InputBatch;
import com.farmrecorder.domain.port.InputBatchRepositoryPort;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;

@Path("/api/v1/input-batches")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Input Batches", description = "Manage chemical and fertilizer inventory lots")
public class InputBatchResource {

    private final InputBatchRepositoryPort inputBatchRepository;

    @Inject
    public InputBatchResource(InputBatchRepositoryPort inputBatchRepository) {
        this.inputBatchRepository = inputBatchRepository;
    }

    @POST
    @RolesAllowed("ADMIN")
    @Operation(summary = "Register a new input batch (admin only)", description = "Adds a lot/batch of pesticide or fertilizer to the inventory")
    @APIResponse(responseCode = "201", description = "Input batch registered successfully",
        content = @Content(schema = @Schema(implementation = InputBatch.class)))
    public Response register(InputBatch batch) {
        InputBatch saved = inputBatchRepository.save(batch);
        return Response.status(Response.Status.CREATED).entity(saved).build();
    }

    @GET
    @Operation(summary = "List all inventory batches", description = "Retrieves all registered chemical and fertilizer lots")
    @APIResponse(responseCode = "200", description = "List of input batches",
        content = @Content(schema = @Schema(implementation = InputBatch.class, type = org.eclipse.microprofile.openapi.annotations.enums.SchemaType.ARRAY)))
    public List<InputBatch> getAll() {
        return inputBatchRepository.getAll();
    }

    @GET
    @Path("/lookup")
    @Operation(summary = "Look up a batch by GTIN and Lot Number", description = "Retrieves stock details for a scanned barcode")
    @APIResponse(responseCode = "200", description = "Input batch matching the barcode",
        content = @Content(schema = @Schema(implementation = InputBatch.class)))
    @APIResponse(responseCode = "404", description = "Inventory batch not found")
    public Response lookup(@QueryParam("gtin") String gtin, @QueryParam("lotNumber") String lotNumber) {
        return inputBatchRepository.findByGtinAndLotNumber(gtin, lotNumber)
            .map(batch -> Response.ok(batch).build())
            .orElseGet(() -> Response.status(Response.Status.NOT_FOUND).build());
    }
}
