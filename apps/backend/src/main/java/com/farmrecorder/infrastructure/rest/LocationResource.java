package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.LocationService;
import com.farmrecorder.domain.model.Location;
import io.quarkus.security.Authenticated;
import io.smallrye.common.annotation.RunOnVirtualThread;
import io.smallrye.mutiny.Uni;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.enums.SchemaType;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import java.util.UUID;

@Path("/api/v1/locations")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Locations", description = "Manage farm locations with GS1 GLN and GPS boundaries")
public class LocationResource {

    private final LocationService locationService;

    @Inject
    public LocationResource(LocationService locationService) {
        this.locationService = locationService;
    }

    @POST
    @Operation(summary = "Create a new farm location", description = "Registers a new field or facility with its GLN and GeoJSON boundary")
    @APIResponse(responseCode = "201", description = "Location created successfully",
        content = @Content(schema = @Schema(implementation = Location.class)))
    public Uni<Response> create(Location location) {
        return Uni.createFrom().item(() -> {
            Location created = locationService.create(location);
            return Response.status(Response.Status.CREATED).entity(created).build();
        });
    }

    @GET
    @Operation(summary = "Get all locations", description = "Retrieves a list of all registered farm locations")
    @APIResponse(responseCode = "200", description = "List of locations",
        content = @Content(schema = @Schema(implementation = Location.class, type = SchemaType.ARRAY)))
    public Uni<List<Location>> getAll() {
        return Uni.createFrom().item(locationService::getAll);
    }

    @GET
    @Path("/{id}")
    @Operation(summary = "Get location by ID", description = "Retrieves a specific location by its UUID")
    @APIResponse(responseCode = "200", description = "Location found",
        content = @Content(schema = @Schema(implementation = Location.class)))
    @APIResponse(responseCode = "404", description = "Location not found")
    public Uni<Response> getById(@PathParam("id") UUID id) {
        return Uni.createFrom().item(() ->
            locationService.getById(id)
                .map(loc -> Response.ok(loc).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build())
        );
    }

    @DELETE
    @Path("/{id}")
    @Operation(summary = "Delete a location", description = "Removes a location from the system")
    @APIResponse(responseCode = "204", description = "Location deleted successfully")
    public Uni<Response> delete(@PathParam("id") UUID id) {
        return Uni.createFrom().item(() -> {
            locationService.delete(id);
            return Response.noContent().build();
        });
    }
}
