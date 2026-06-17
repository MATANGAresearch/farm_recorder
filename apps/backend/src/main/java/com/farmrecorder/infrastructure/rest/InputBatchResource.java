package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.domain.model.InputBatch;
import com.farmrecorder.domain.port.InputBatchRepositoryPort;
import io.smallrye.common.annotation.Blocking;
import io.smallrye.mutiny.Uni;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
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
@Blocking
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
    public Uni<Response> register(InputBatch batch) {
        return Uni.createFrom().item(() -> {
            InputBatch saved = inputBatchRepository.save(batch);
            return Response.status(Response.Status.CREATED).entity(saved).build();
        });
    }

    @GET
    @Operation(summary = "List all inventory batches", description = "Retrieves all registered chemical and fertilizer lots")
    @APIResponse(responseCode = "200", description = "List of input batches",
        content = @Content(schema = @Schema(implementation = InputBatch.class, type = org.eclipse.microprofile.openapi.annotations.enums.SchemaType.ARRAY)))
    public Uni<List<InputBatch>> getAll() {
        return Uni.createFrom().item(inputBatchRepository::getAll);
    }

    @GET
    @Path("/lookup")
    @Operation(summary = "Look up a batch by GTIN and Lot Number", description = "Retrieves stock details for a scanned barcode")
    @APIResponse(responseCode = "200", description = "Input batch matching the barcode",
        content = @Content(schema = @Schema(implementation = InputBatch.class)))
    @APIResponse(responseCode = "404", description = "Inventory batch not found")
    public Uni<Response> lookup(@QueryParam("gtin") String gtin, @QueryParam("lotNumber") String lotNumber) {
        return Uni.createFrom().item(() -> inputBatchRepository.findByGtinAndLotNumber(gtin, lotNumber)
            .map(batch -> Response.ok(batch).build())
            .orElseGet(() -> Response.status(Response.Status.NOT_FOUND).build()));
    }
}
