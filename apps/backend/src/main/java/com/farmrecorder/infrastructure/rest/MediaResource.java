package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.MediaService;
import com.farmrecorder.domain.model.Media;
import com.farmrecorder.infrastructure.storage.S3Service;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.enums.SchemaType;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Path("/api/v1/media")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Media", description = "Manage photos and media attached to activity logs")
public class MediaResource {

    private final MediaService mediaService;
    private final S3Service s3Service;

    @Inject
    public MediaResource(MediaService mediaService, S3Service s3Service) {
        this.mediaService = mediaService;
        this.s3Service = s3Service;
    }

    @POST
    @Path("/presigned-url")
    @Operation(summary = "Get presigned URL for media upload", description = "Generates a temporary presigned URL for uploading a photo directly to MinIO in a hierarchical folder structure")
    @APIResponse(responseCode = "200", description = "Presigned URL generated",
        content = @Content(schema = @Schema(implementation = Map.class)))
    public Response getPresignedUrl(@QueryParam("farmId") String farmId,
                                    @QueryParam("taskId") String taskId,
                                    @QueryParam("fileName") String fileName,
                                    @QueryParam("contentType") String contentType) {
        if (farmId == null || taskId == null || fileName == null || contentType == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "farmId, taskId, fileName, and contentType are required"))
                    .build();
        }

        String uploadUrl = s3Service.generatePresignedUploadUrl(farmId, taskId, fileName, contentType);

        Map<String, String> response = new HashMap<>();
        response.put("uploadUrl", uploadUrl);
        response.put("message", "Use PUT request to this URL with the file binary");

        return Response.ok(response).build();
    }

    @POST
    @Operation(summary = "Record media metadata for an activity log", description = "Records media metadata after the image has been uploaded to MinIO via presigned URL")
    @APIResponse(responseCode = "201", description = "Media recorded successfully",
        content = @Content(schema = @Schema(implementation = Media.class)))
    public Response create(Media media) {
        Media created = mediaService.create(media);
        return Response.status(Response.Status.CREATED).entity(created).build();
    }

    @GET
    @Path("/activity/{activityLogId}")
    @Operation(summary = "Get media by activity log ID", description = "Retrieves all media associated with a specific activity log")
    @APIResponse(responseCode = "200", description = "List of media",
        content = @Content(schema = @Schema(implementation = Media.class, type = SchemaType.ARRAY)))
    public List<Media> getByActivityLogId(@PathParam("activityLogId") UUID activityLogId) {
        return mediaService.getByActivityLogId(activityLogId);
    }
}
