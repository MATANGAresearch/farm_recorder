package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.FarmService;
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

    private final FarmService farmService;

    @Inject
    public FarmResource(FarmService farmService) {
        this.farmService = farmService;
    }

    @POST
    @RolesAllowed("ADMIN")
    @Operation(summary = "Create a new farm", description = "Registers a new farm owned by the authenticated user. Restricted to admin role.")
    @APIResponse(responseCode = "201", description = "Farm created successfully")
    public Uni<Response> create(Farm farm, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            String ownerId = securityContext.getUserPrincipal().getName();
            Farm createdFarm = new Farm(IdGenerator.generate(), farm.name(), ownerId);
            Farm saved = farmService.create(createdFarm);
            return Response.status(Response.Status.CREATED).entity(saved).build();
        });
    }

    @GET
    @Operation(summary = "Get all farms for the current user", description = "Retrieves farms owned by or assigned to the user")
    @APIResponse(responseCode = "200", description = "List of farms")
    public Uni<List<Farm>> getAll(@Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            // Allow Admins to see all, while workers see owned/assigned
            boolean isAdmin = securityContext.isUserInRole("ADMIN");
            if (isAdmin) {
                return farmService.getAll();
            } else {
                String ownerId = securityContext.getUserPrincipal().getName();
                return farmService.getByOwner(ownerId);
            }
        });
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    @Operation(summary = "Delete a farm", description = "Removes a farm from the system. Restricted to admin role.")
    @APIResponse(responseCode = "204", description = "Farm deleted successfully")
    public Uni<Response> delete(@PathParam("id") UUID id) {
        return Uni.createFrom().item(() -> {
            farmService.delete(id);
            return Response.noContent().build();
        });
    }
}
