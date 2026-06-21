package com.farmrecorder.infrastructure.rest;

import com.farmrecorder.application.ProductService;
import com.farmrecorder.domain.model.Product;
import io.smallrye.common.annotation.RunOnVirtualThread;
import jakarta.annotation.security.RolesAllowed;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
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

@Path("/api/v1/products")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RolesAllowed({"FARM_WORKER", "ADMIN"})
@RunOnVirtualThread
@Tag(name = "Products", description = "Manage farm products with GS1 GTIN")
public class ProductResource {

    private final ProductService productService;

    @Inject
    public ProductResource(ProductService productService) {
        this.productService = productService;
    }

    @POST
    @Operation(summary = "Create a new product", description = "Registers a new product with its GTIN. Restricted to admin role.")
    @APIResponse(responseCode = "201", description = "Product created successfully",
        content = @Content(schema = @Schema(implementation = Product.class)))
    public Response create(@Valid Product product) {
        Product created = productService.create(product);
        return Response.status(Response.Status.CREATED).entity(created).build();
    }

    @PUT
    @Operation(summary = "Update an existing product", description = "Updates product details. Restricted to admin role.")
    @APIResponse(responseCode = "200", description = "Product updated successfully",
        content = @Content(schema = @Schema(implementation = Product.class)))
    public Response update(@Valid Product product) {
        Product updated = productService.update(product);
        return Response.ok(updated).build();
    }

    @GET
    @Operation(summary = "Get all products", description = "Retrieves a list of all registered products")
    @APIResponse(responseCode = "200", description = "List of products",
        content = @Content(schema = @Schema(implementation = Product.class, type = SchemaType.ARRAY)))
    public List<Product> getAll() {
        return productService.getAll();
    }

    @GET
    @Path("/{id}")
    @Operation(summary = "Get product by ID", description = "Retrieves a specific product by its UUID")
    @APIResponse(responseCode = "200", description = "Product found",
        content = @Content(schema = @Schema(implementation = Product.class)))
    @APIResponse(responseCode = "404", description = "Product not found")
    public Response getById(@PathParam("id") UUID id) {
        return productService.getById(id)
                .map(p -> Response.ok(p).build())
                .orElse(Response.status(Response.Status.NOT_FOUND).build());
    }
}
