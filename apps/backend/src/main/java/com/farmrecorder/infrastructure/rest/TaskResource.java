package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.TaskService;
import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Task;
import com.farmrecorder.domain.model.TaskStatus;
import io.smallrye.common.annotation.RunOnVirtualThread;
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

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Path("/api/v1/tasks")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Tasks", description = "Manage farm tasks and assignments")
public class TaskResource {

    private final TaskService taskService;

    @Inject
    public TaskResource(TaskService taskService) {
        this.taskService = taskService;
    }

    @POST
    @Operation(summary = "Create a new task", description = "Assigns a new task to a worker within a specific farm")
    @APIResponse(responseCode = "201", description = "Task created successfully")
    public Uni<Response> create(Task task, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            // Manager/Admin creates the task
            Task createdTask = new Task(
                IdGenerator.generate(),
                task.farmId(),
                task.assignedTo(),
                task.title(),
                task.description(),
                TaskStatus.PENDING,
                task.dueDate() != null ? task.dueDate() : Instant.now().plusSeconds(86400)
            );
            Task saved = taskService.create(createdTask);
            return Response.status(Response.Status.CREATED).entity(saved).build();
        });
    }

    @GET
    @Path("/farm/{farmId}")
    @Operation(summary = "Get tasks for a farm", description = "Retrieves all tasks for a specific farm")
    @APIResponse(responseCode = "200", description = "List of tasks")
    public Uni<List<Task>> getByFarmId(@PathParam("farmId") UUID farmId) {
        return Uni.createFrom().item(() -> {
            return taskService.getByFarmId(farmId);
        });
    }

    @GET
    @Path("/my-tasks")
    @Operation(summary = "Get my assigned tasks", description = "Retrieves all tasks assigned to the currently authenticated user")
    @APIResponse(responseCode = "200", description = "List of assigned tasks")
    public Uni<List<Task>> getMyTasks(@Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            String currentUser = securityContext.getUserPrincipal().getName();
            return taskService.getByAssignedUser(currentUser);
        });
    }

    @GET
    @Path("/assigned/{username}")
    @Operation(summary = "Get tasks assigned to a user", description = "Retrieves all tasks assigned to a specific worker")
    @APIResponse(responseCode = "200", description = "List of assigned tasks")
    public Uni<List<Task>> getByAssignedUser(@PathParam("username") String username) {
        return Uni.createFrom().item(() -> {
            return taskService.getByAssignedUser(username);
        });
    }

    @PATCH
    @Path("/{id}/status")
    @Operation(summary = "Update task status", description = "Allows a worker to mark as COMPLETED or a manager to mark as REVIEWED")
    @APIResponse(responseCode = "200", description = "Task status updated")
    public Uni<Response> updateStatus(@PathParam("id") UUID id, @QueryParam("status") TaskStatus newStatus, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            Task updated = taskService.updateStatus(id, newStatus);
            return Response.ok().entity(updated).build();
        });
    }
}
