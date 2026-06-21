package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.FarmService;
import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.infrastructure.persistence.FarmWorkerEntity;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.eclipse.microprofile.jwt.JsonWebToken;
import org.eclipse.microprofile.openapi.annotations.Operation;
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

    public static class AddWorkerRequest {
        @Email
        @NotBlank
        public String email;
        
        @NotBlank
        public String role; // "ADMIN", "WORKER", "READONLY"
    }

    private void checkFarmAdmin(UUID farmId) {
        String email = jwt.getClaim("email");
        if (email == null) {
            email = jwt.getName();
        }
        Farm farm = farmService.getById(farmId).orElse(null);
        if (farm == null) {
            throw new jakarta.ws.rs.WebApplicationException("Farm not found", Response.Status.NOT_FOUND);
        }
        if (farm.ownerId().equals(jwt.getName()) || farm.ownerId().equals(email)) {
            return; // Owner is admin
        }
        
        FarmWorkerEntity mapping = FarmWorkerEntity.find("farmId = ?1 and workerEmail = ?2", farmId, email).firstResult();
        if (mapping == null || !"ADMIN".equals(mapping.role)) {
            throw new jakarta.ws.rs.WebApplicationException("Forbidden: You must be a farm admin", Response.Status.FORBIDDEN);
        }
    }

    private void checkFarmMember(UUID farmId) {
        String email = jwt.getClaim("email");
        if (email == null) {
            email = jwt.getName();
        }
        Farm farm = farmService.getById(farmId).orElse(null);
        if (farm == null) {
            throw new jakarta.ws.rs.WebApplicationException("Farm not found", Response.Status.NOT_FOUND);
        }
        if (farm.ownerId().equals(jwt.getName()) || farm.ownerId().equals(email)) {
            return;
        }
        long count = FarmWorkerEntity.count("farmId = ?1 and workerEmail = ?2", farmId, email);
        if (count == 0) {
            throw new jakarta.ws.rs.WebApplicationException("Forbidden: You are not a member of this farm", Response.Status.FORBIDDEN);
        }
    }

    @POST
    @Transactional
    @Operation(summary = "Create a new farm", description = "Registers a new farm owned by the authenticated user.")
    @APIResponse(responseCode = "201", description = "Farm created successfully")
    public Response create(@Valid Farm farm, @Context SecurityContext securityContext) {
        String ownerId = securityContext.getUserPrincipal().getName();
        String email = jwt.getClaim("email");
        if (email == null) {
            email = ownerId;
        }
        Farm createdFarm = new Farm(IdGenerator.generate(), farm.name(), ownerId);
        Farm saved = farmService.create(createdFarm);
        
        // Ensure Worker profile exists
        com.farmrecorder.infrastructure.persistence.WorkerEntity worker = 
            com.farmrecorder.infrastructure.persistence.WorkerEntity.find("username", email).firstResult();
        if (worker == null) {
            worker = new com.farmrecorder.infrastructure.persistence.WorkerEntity();
            worker.id = IdGenerator.generate();
            worker.username = email;
            worker.fullName = email.split("@")[0];
            worker.persist();
        }
        
        // Link creator as ADMIN
        FarmWorkerEntity fw = new FarmWorkerEntity(saved.id(), email, "ADMIN");
        fw.persist();
        
        return Response.status(Response.Status.CREATED).entity(saved).build();
    }

    @GET
    @Operation(summary = "Get all farms for the current user", description = "Retrieves farms owned by or assigned to the user")
    @APIResponse(responseCode = "200", description = "List of farms")
    public List<Farm> getAll(@Context SecurityContext securityContext) {
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
    }

    @GET
    @Path("/{farmId}/workers")
    @Operation(summary = "Get workers assigned to a farm", description = "Retrieves a list of workers assigned to the specified farm.")
    @APIResponse(responseCode = "200", description = "List of farm members")
    public Response getAssignedWorkers(@PathParam("farmId") UUID farmId) {
        checkFarmMember(farmId);
        List<FarmWorkerEntity> list = FarmWorkerEntity.list("farmId", farmId);
        List<java.util.Map<String, String>> members = list.stream()
            .map(fw -> java.util.Map.of("email", fw.workerEmail, "role", fw.role))
            .collect(Collectors.toList());
        return Response.ok(members).build();
    }

    @POST
    @Path("/{farmId}/workers")
    @Transactional
    @Operation(summary = "Add a worker to a farm with a role", description = "Maps a worker's email to a farm with a role.")
    @APIResponse(responseCode = "201", description = "Worker assigned successfully")
    public Response assignWorker(@PathParam("farmId") UUID farmId, @Valid AddWorkerRequest req) {
        checkFarmAdmin(farmId);
        
        String role = req.role.toUpperCase();
        if (!List.of("ADMIN", "WORKER", "READONLY").contains(role)) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "Invalid role. Must be ADMIN, WORKER, or READONLY.")).build();
        }
        
        com.farmrecorder.infrastructure.persistence.WorkerEntity worker = 
            com.farmrecorder.infrastructure.persistence.WorkerEntity.find("username", req.email).firstResult();
        if (worker == null) {
            worker = new com.farmrecorder.infrastructure.persistence.WorkerEntity();
            worker.id = IdGenerator.generate();
            worker.username = req.email;
            worker.fullName = req.email.split("@")[0];
            worker.persist();
        }
        
        FarmWorkerEntity.delete("farmId = ?1 and workerEmail = ?2", farmId, req.email);
        FarmWorkerEntity fw = new FarmWorkerEntity(farmId, req.email, role);
        fw.persist();
        
        return Response.status(Response.Status.CREATED).build();
    }

    @PUT
    @Path("/{farmId}/workers/{email}/role")
    @Transactional
    @Operation(summary = "Update worker role on a farm", description = "Updates a worker's assigned role on a specific farm.")
    @APIResponse(responseCode = "200", description = "Role updated successfully")
    public Response updateWorkerRole(@PathParam("farmId") UUID farmId, @PathParam("email") String email, String rolePayload) {
        checkFarmAdmin(farmId);
        
        String role = rolePayload.replaceAll("[\"{}]", "").trim();
        if (role.contains(":")) {
            role = role.split(":")[1].replaceAll("\"", "").trim();
        }
        role = role.toUpperCase();
        
        if (!List.of("ADMIN", "WORKER", "READONLY").contains(role)) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "Invalid role. Must be ADMIN, WORKER, or READONLY.")).build();
        }
        
        Farm farm = farmService.getById(farmId).orElse(null);
        if (farm != null && farm.ownerId().equals(email)) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "Cannot modify the role of the farm owner.")).build();
        }
        
        FarmWorkerEntity mapping = FarmWorkerEntity.find("farmId = ?1 and workerEmail = ?2", farmId, email).firstResult();
        if (mapping == null) {
            return Response.status(Response.Status.NOT_FOUND)
                .entity(java.util.Map.of("error", "Worker mapping not found.")).build();
        }
        
        mapping.role = role;
        mapping.persist();
        return Response.ok().build();
    }

    @DELETE
    @Path("/{farmId}/workers/{email}")
    @Transactional
    @Operation(summary = "Unassign a worker from a farm", description = "Removes the mapping between a worker and a farm.")
    @APIResponse(responseCode = "204", description = "Worker unassigned successfully")
    public Response unassignWorker(@PathParam("farmId") UUID farmId, @PathParam("email") String email) {
        checkFarmAdmin(farmId);
        
        Farm farm = farmService.getById(farmId).orElse(null);
        if (farm != null && farm.ownerId().equals(email)) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "Cannot remove the farm owner from the farm.")).build();
        }
        
        FarmWorkerEntity.delete("farmId = ?1 and workerEmail = ?2", farmId, email);
        return Response.noContent().build();
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    @Operation(summary = "Delete a farm", description = "Removes a farm from the system. Restricted to admin role.")
    @APIResponse(responseCode = "204", description = "Farm deleted successfully")
    public Response delete(@PathParam("id") UUID id) {
        farmService.delete(id);
        return Response.noContent().build();
    }
}
