package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.TaskService;
import com.farmrecorder.application.FarmService;
import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Task;
import com.farmrecorder.domain.model.TaskStatus;
import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.infrastructure.persistence.FarmWorkerEntity;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.PATCH;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.eclipse.microprofile.jwt.JsonWebToken;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Path("/api/v1/tasks")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Tasks", description = "Manage farm tasks and assignments")
public class TaskResource {

    private final TaskService taskService;
    private final FarmService farmService;

    @Inject
    JsonWebToken jwt;

    @Inject
    public TaskResource(TaskService taskService, FarmService farmService) {
        this.taskService = taskService;
        this.farmService = farmService;
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
    @Operation(summary = "Create a new task", description = "Assigns a new task to a worker within a specific farm")
    @APIResponse(responseCode = "201", description = "Task created successfully")
    public Response create(Task task, @Context SecurityContext securityContext) {
        checkFarmAdmin(task.farmId());
        
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
    }

    @POST
    @Path("/bulk")
    @Transactional
    @Operation(summary = "Bulk create tasks", description = "Allows farm admins to create multiple tasks at once")
    @APIResponse(responseCode = "201", description = "Tasks created successfully")
    public Response createBulk(List<Task> tasks) {
        if (tasks == null || tasks.isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "Task list cannot be empty")).build();
        }
        
        // Group tasks by farmId to check admin permission for each farm
        java.util.Set<UUID> farmIds = tasks.stream()
            .map(Task::farmId)
            .filter(java.util.Objects::nonNull)
            .collect(java.util.stream.Collectors.toSet());
            
        if (farmIds.isEmpty() || tasks.stream().anyMatch(t -> t.farmId() == null)) {
            return Response.status(Response.Status.BAD_REQUEST)
                .entity(java.util.Map.of("error", "farmId is required for all tasks")).build();
        }

        for (UUID farmId : farmIds) {
            checkFarmAdmin(farmId);
        }
        
        java.util.List<Task> savedTasks = new java.util.ArrayList<>();
        for (Task task : tasks) {
            Task createdTask = new Task(
                IdGenerator.generate(),
                task.farmId(),
                task.assignedTo(),
                task.title(),
                task.description(),
                TaskStatus.PENDING,
                task.dueDate() != null ? task.dueDate() : Instant.now().plusSeconds(86400)
            );
            savedTasks.add(taskService.create(createdTask));
        }
        
        return Response.status(Response.Status.CREATED).entity(savedTasks).build();
    }

    @GET
    @Path("/farm/{farmId}")
    @Operation(summary = "Get tasks for a farm", description = "Retrieves all tasks for a specific farm")
    @APIResponse(responseCode = "200", description = "List of tasks")
    public List<Task> getByFarmId(@PathParam("farmId") UUID farmId) {
        checkFarmMember(farmId);
        return taskService.getByFarmId(farmId);
    }

    @GET
    @Path("/my-tasks")
    @Operation(summary = "Get my assigned tasks", description = "Retrieves all tasks assigned to the currently authenticated user")
    @APIResponse(responseCode = "200", description = "List of assigned tasks")
    public List<Task> getMyTasks(@Context SecurityContext securityContext) {
        String currentUser = securityContext.getUserPrincipal().getName();
        return taskService.getByAssignedUser(currentUser);
    }

    @GET
    @Path("/assigned/{username}")
    @Operation(summary = "Get tasks assigned to a user", description = "Retrieves all tasks assigned to a specific worker")
    @APIResponse(responseCode = "200", description = "List of assigned tasks")
    public List<Task> getByAssignedUser(@PathParam("username") String username) {
        String email = jwt.getClaim("email");
        if (email == null) {
            email = jwt.getName();
        }
        if (username.equals(email) || username.equals(jwt.getName())) {
            return taskService.getByAssignedUser(username);
        }
        
        // Find farms where the target user is a worker
        List<FarmWorkerEntity> targetFarms = FarmWorkerEntity.list("workerEmail", username);
        boolean hasAccess = false;
        for (FarmWorkerEntity targetFw : targetFarms) {
            try {
                checkFarmAdmin(targetFw.farmId);
                hasAccess = true;
                break;
            } catch (Exception e) {
                // Ignore and check other farms
            }
        }
        if (!hasAccess) {
            throw new jakarta.ws.rs.WebApplicationException("Forbidden: You cannot view this worker's tasks", Response.Status.FORBIDDEN);
        }
        return taskService.getByAssignedUser(username);
    }

    @PATCH
    @Path("/{id}/status")
    @Transactional
    @Operation(summary = "Update task status", description = "Allows a worker to mark as COMPLETED or a manager to mark as REVIEWED")
    @APIResponse(responseCode = "200", description = "Task status updated")
    public Response updateStatus(@PathParam("id") UUID id, @QueryParam("status") TaskStatus newStatus, @Context SecurityContext securityContext) {
        Task task = taskService.getById(id).orElse(null);
        if (task == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        
        if (newStatus == TaskStatus.REVIEWED) {
            checkFarmAdmin(task.farmId());
        } else {
            checkFarmMember(task.farmId());
        }
        
        Task updated = taskService.updateStatus(id, newStatus);
        return Response.ok().entity(updated).build();
    }
}

