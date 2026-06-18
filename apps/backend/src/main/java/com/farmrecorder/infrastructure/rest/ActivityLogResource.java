package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.ActivityLogService;
import com.farmrecorder.domain.model.ActivityLog;
import io.quarkus.security.Authenticated;
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
import org.eclipse.microprofile.openapi.annotations.enums.SchemaType;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Path("/api/v1/activity-logs")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Activity Logs", description = "Record and retrieve farm activities for GAP certification")
public class ActivityLogResource {

    private final ActivityLogService activityLogService;

    @Inject
    public ActivityLogResource(ActivityLogService activityLogService) {
        this.activityLogService = activityLogService;
    }

    @POST
    @Operation(summary = "Create a new activity log", description = "Records a farm activity with GPS coordinates, optionally linked to a task or harvest batch, triggering EPCIS event")
    @APIResponse(responseCode = "201", description = "Activity log created successfully",
        content = @Content(schema = @Schema(implementation = ActivityLog.class)))
    public Uni<Response> create(ActivityLog activityLog, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            // Extract actual user ID (username) from JWT token (upn claim)
            String userId = securityContext.getUserPrincipal().getName();

            // Override the userId from the payload with the authenticated user's ID
            ActivityLog secureLog = new ActivityLog(
                activityLog.id(),
                activityLog.timestamp(),
                userId,
                activityLog.locationId(),
                activityLog.productId(),
                activityLog.taskId(),
                activityLog.type(),
                activityLog.notes(),
                activityLog.gpsLat(),
                activityLog.gpsLng(),
                activityLog.startTime(),
                activityLog.endTime(),
                activityLog.batchId(),
                activityLog.quantity(),
                activityLog.unitPrice(),
                activityLog.totalPrice(),
                activityLog.customerName(),
                activityLog.customerPhone(),
                activityLog.customerEmail(),
                activityLog.chemicalLotNumber(),
                activityLog.chemicalExpirationDate(),
                activityLog.applicationRate(),
                activityLog.totalQuantityApplied(),
                activityLog.weatherWindSpeed(),
                activityLog.weatherWindDirection(),
                activityLog.weatherTemperature(),
                activityLog.applicatorLicense(),
                activityLog.isManualInput(),
                activityLog.manualInputComments(),
                activityLog.verificationStatus(),
                activityLog.verifiedBy(),
                activityLog.verifiedAt(),
                activityLog.reiEndTime()
            );

            ActivityLog created = activityLogService.create(secureLog, securityContext.isUserInRole("ADMIN"));
            return Response.status(Response.Status.CREATED).entity(created).build();
        });
    }

    @PUT
    @Operation(summary = "Update or override an existing activity log", description = "Updates details of an activity log. Restricted to admin role.")
    @APIResponse(responseCode = "200", description = "Activity log updated successfully",
        content = @Content(schema = @Schema(implementation = ActivityLog.class)))
    @RolesAllowed("ADMIN")
    public Uni<Response> update(ActivityLog activityLog, @Context SecurityContext securityContext) {
        return Uni.createFrom().item(() -> {
            String adminUser = securityContext.getUserPrincipal().getName();
            String vStatus = activityLog.verificationStatus();
            String verifiedBy = activityLog.verifiedBy();
            Instant verifiedAt = activityLog.verifiedAt();

            if (vStatus != null && ("VERIFIED".equalsIgnoreCase(vStatus) || "AUDITED".equalsIgnoreCase(vStatus))) {
                if (verifiedBy == null || verifiedBy.trim().isEmpty()) {
                    verifiedBy = adminUser;
                }
                if (verifiedAt == null) {
                    verifiedAt = Instant.now();
                }
            }

            ActivityLog secureLog = new ActivityLog(
                activityLog.id(),
                activityLog.timestamp(),
                activityLog.userId(),
                activityLog.locationId(),
                activityLog.productId(),
                activityLog.taskId(),
                activityLog.type(),
                activityLog.notes(),
                activityLog.gpsLat(),
                activityLog.gpsLng(),
                activityLog.startTime(),
                activityLog.endTime(),
                activityLog.batchId(),
                activityLog.quantity(),
                activityLog.unitPrice(),
                activityLog.totalPrice(),
                activityLog.customerName(),
                activityLog.customerPhone(),
                activityLog.customerEmail(),
                activityLog.chemicalLotNumber(),
                activityLog.chemicalExpirationDate(),
                activityLog.applicationRate(),
                activityLog.totalQuantityApplied(),
                activityLog.weatherWindSpeed(),
                activityLog.weatherWindDirection(),
                activityLog.weatherTemperature(),
                activityLog.applicatorLicense(),
                activityLog.isManualInput(),
                activityLog.manualInputComments(),
                vStatus,
                verifiedBy,
                verifiedAt,
                activityLog.reiEndTime()
            );

            ActivityLog updated = activityLogService.update(secureLog);
            return Response.ok(updated).build();
        });
    }

    @GET
    @Path("/{id}")
    @Operation(summary = "Get activity log by ID", description = "Retrieves a specific activity log")
    @APIResponse(responseCode = "200", description = "Activity log found",
        content = @Content(schema = @Schema(implementation = ActivityLog.class)))
    @APIResponse(responseCode = "404", description = "Activity log not found")
    public Uni<Response> getById(@PathParam("id") UUID id) {
        return Uni.createFrom().item(() ->
            activityLogService.getById(id)
                .map(log -> Response.ok(log).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build())
        );
    }

    @GET
    @Path("/location/{locationId}")
    @Operation(summary = "Get activity logs by location", description = "Retrieves all activity logs for a specific farm location")
    @APIResponse(responseCode = "200", description = "List of activity logs",
        content = @Content(schema = @Schema(implementation = ActivityLog.class, type = SchemaType.ARRAY)))
    public Uni<List<ActivityLog>> getByLocationId(@PathParam("locationId") UUID locationId) {
        return Uni.createFrom().item(() -> activityLogService.getByLocationId(locationId));
    }

    @GET
    @Path("/task/{taskId}")
    @Operation(summary = "Get activity log by task ID", description = "Retrieves the activity log associated with a specific task")
    @APIResponse(responseCode = "200", description = "Activity log found",
        content = @Content(schema = @Schema(implementation = ActivityLog.class)))
    @APIResponse(responseCode = "404", description = "Activity log not found")
    public Uni<Response> getByTaskId(@PathParam("taskId") UUID taskId) {
        return Uni.createFrom().item(() ->
            activityLogService.getByTaskId(taskId)
                .map(log -> Response.ok(log).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build())
        );
    }
}
