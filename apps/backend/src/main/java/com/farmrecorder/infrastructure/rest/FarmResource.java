package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.FarmService;
import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.infrastructure.persistence.FarmWorkerEntity;
import io.smallrye.common.annotation.RunOnVirtualThread;
import io.smallrye.mutiny.Uni;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.eclipse.microprofile.jwt.JsonWebToken;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Path("/api/v1/farms")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Farms", description = "Manage farms and ownership")
public class FarmResource {

    private final FarmService farmService;

    @Inject
    JsonWebToken jwt;

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
            // Allow Admins to see all, while workers see assigned farms
            boolean isAdmin = securityContext.isUserInRole("ADMIN");
            if (isAdmin) {
                return farmService.getAll();
            } else {
                String email = jwt.getClaim("email");
                if (email == null) {
                    email = securityContext.getUserPrincipal().getName();
                }
                return farmService.getAssignedFarms(email);
            }
        });
    }

    @GET
    @Path("/{farmId}/workers")
    @RolesAllowed("ADMIN")
    @Operation(summary = "Get workers assigned to a farm", description = "Retrieves a list of emails of workers assigned to the specified farm.")
    @APIResponse(responseCode = "200", description = "List of worker emails")
    public Uni<List<String>> getAssignedWorkers(@PathParam("farmId") UUID farmId) {
        return Uni.createFrom().item(() -> {
            List<FarmWorkerEntity> list = FarmWorkerEntity.list("farmId", farmId);
            return list.stream().map(fw -> fw.workerEmail).collect(Collectors.toList());
        });
    }

    @POST
    @Path("/{farmId}/workers/{email}")
    @RolesAllowed("ADMIN")
    @Transactional
    @Operation(summary = "Assign a worker to a farm", description = "Maps a worker's email to a farm.")
    @APIResponse(responseCode = "201", description = "Worker assigned successfully")
    public Uni<Response> assignWorker(@PathParam("farmId") UUID farmId, @PathParam("email") String email) {
        return Uni.createFrom().item(() -> {
            long count = FarmWorkerEntity.count("farmId = ?1 and workerEmail = ?2", farmId, email);
            if (count == 0) {
                FarmWorkerEntity fw = new FarmWorkerEntity(farmId, email);
                fw.persist();
            }
            return Response.status(Response.Status.CREATED).build();
        });
    }

    @DELETE
    @Path("/{farmId}/workers/{email}")
    @RolesAllowed("ADMIN")
    @Transactional
    @Operation(summary = "Unassign a worker from a farm", description = "Removes the mapping between a worker and a farm.")
    @APIResponse(responseCode = "204", description = "Worker unassigned successfully")
    public Uni<Response> unassignWorker(@PathParam("farmId") UUID farmId, @PathParam("email") String email) {
        return Uni.createFrom().item(() -> {
            FarmWorkerEntity.delete("farmId = ?1 and workerEmail = ?2", farmId, email);
            return Response.noContent().build();
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
