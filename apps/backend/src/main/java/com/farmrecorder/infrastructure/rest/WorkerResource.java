package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.WorkerService;
import com.farmrecorder.domain.model.Worker;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.jboss.logging.Logger;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.enums.SchemaType;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import java.util.UUID;

@Path("/api/v1/workers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Workers", description = "Manage farm workers and applicator licenses")
public class WorkerResource {

    private static final Logger LOG = Logger.getLogger(WorkerResource.class);

    private final WorkerService workerService;

    @Inject
    public WorkerResource(WorkerService workerService) {
        this.workerService = workerService;
    }

    @POST
    @RolesAllowed("ADMIN")
    @Operation(summary = "Register or update a worker", description = "Saves worker profile and license. Restricted to admin role.")
    @APIResponse(responseCode = "201", description = "Worker registered successfully",
        content = @Content(schema = @Schema(implementation = Worker.class)))
    public Response register(Worker worker) {
        Worker created = workerService.create(worker);
        return Response.status(Response.Status.CREATED).entity(created).build();
    }

    @GET
    @Operation(summary = "Get all workers", description = "Retrieves a list of all registered workers")
    @APIResponse(responseCode = "200", description = "List of workers",
        content = @Content(schema = @Schema(implementation = Worker.class, type = SchemaType.ARRAY)))
    public List<Worker> getAll() {
        return workerService.getAll();
    }

    @GET
    @Path("/{id}")
    @Operation(summary = "Get worker by ID", description = "Retrieves a specific worker by UUID")
    @APIResponse(responseCode = "200", description = "Worker found",
        content = @Content(schema = @Schema(implementation = Worker.class)))
    @APIResponse(responseCode = "404", description = "Worker not found")
    public Response getById(@PathParam("id") UUID id) {
        return workerService.getById(id)
            .map(w -> Response.ok(w).build())
            .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }

    @DELETE
    @Path("/{id}")
    @RolesAllowed("ADMIN")
    @Operation(summary = "Delete a worker registration", description = "Removes a worker from the system. Restricted to admin role.")
    @APIResponse(responseCode = "204", description = "Worker registration deleted")
    public Response delete(@PathParam("id") UUID id) {
        workerService.delete(id);
        return Response.noContent().build();
    }

    @POST
    @Path("/{email}/promote")
    @RolesAllowed("ADMIN")
    @Operation(summary = "Promote a worker to Admin", description = "Sets custom claims on Firebase Auth to grant the ADMIN role. Restricted to admin role.")
    @APIResponse(responseCode = "200", description = "User promoted to admin successfully")
    @APIResponse(responseCode = "400", description = "Firebase SDK not initialized or user not found")
    public Response promote(@PathParam("email") String email) {
        if (com.google.firebase.FirebaseApp.getApps().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(java.util.Map.of("error", "Firebase Admin SDK is not initialized"))
                    .build();
        }

        try {
            com.google.firebase.auth.UserRecord userRecord = com.google.firebase.auth.FirebaseAuth.getInstance()
                    .getUserByEmail(email);
            
            java.util.Map<String, Object> claims = new java.util.HashMap<>(userRecord.getCustomClaims());
            claims.put("role", "ADMIN");
            
            com.google.firebase.auth.FirebaseAuth.getInstance().setCustomUserClaims(userRecord.getUid(), claims);
            LOG.info("✅ Promoted user " + email + " to ADMIN role on Firebase.");
            return Response.ok(java.util.Map.of("message", "User promoted to admin successfully")).build();
        } catch (com.google.firebase.auth.FirebaseAuthException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(java.util.Map.of("error", "Firebase error: " + e.getMessage()))
                    .build();
        }
    }
}
