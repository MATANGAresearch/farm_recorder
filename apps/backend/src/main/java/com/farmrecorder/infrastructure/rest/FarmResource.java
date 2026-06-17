package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Farm;
import io.smallrye.common.annotation.Blocking;
import io.smallrye.mutiny.Uni;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import java.util.UUID;

@Path("/api/v1/farms")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@Blocking
@Tag(name = "Farms", description = "Manage farms and ownership")
public class FarmResource {

    // Simplified in-memory or Panache repository would go here.
    // For this step, we'll provide a basic structure. In a full implementation,
    // this would inject FarmService.

    @POST
    @Operation(summary = "Create a new farm", description = "Registers a new farm owned by the authenticated user")
    @APIResponse(responseCode = "201", description = "Farm created successfully")
    public Uni<Response> create(Farm farm, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            String ownerId = securityContext.getUserPrincipal().getName();
            Farm createdFarm = new Farm(IdGenerator.generate(), farm.name(), ownerId);
            // TODO: Save via FarmService
            return Response.status(Response.Status.CREATED).entity(createdFarm).build();
        });
    }

    @GET
    @Operation(summary = "Get all farms for the current user", description = "Retrieves farms owned by or assigned to the user")
    @APIResponse(responseCode = "200", description = "List of farms")
    public Uni<List<Farm>> getAll(@Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            // TODO: Fetch via FarmService by ownerId
            return List.of();
        });
    }
}
