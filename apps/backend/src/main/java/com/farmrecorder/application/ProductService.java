package com.farmrecorder.application;

import com.farmrecorder.domain.model.Product;
import com.farmrecorder.domain.port.ProductRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class ProductService {

    private final ProductRepositoryPort repository;

    @Inject
    public ProductService(ProductRepositoryPort repository) {
        this.repository = repository;
    }

    public Product create(Product product) {
        String gtin = product.gtin();
        Boolean isLocalOnly = product.isLocalOnly();

        if (gtin == null || gtin.trim().isEmpty()) {
            // Generate a private-range GS1 GTIN-like code (using the 046 prefix for internal distribution)
            gtin = "046" + String.format("%010d", System.currentTimeMillis() / 1000);
            isLocalOnly = true;
        }

        Product secureProduct = new Product(
            product.id() != null ? product.id() : com.farmrecorder.core.util.IdGenerator.generate(),
            gtin,
            product.name(),
            product.variety(),
            product.batchPrefix(),
            product.defaultUnitPrice(),
            product.type() != null ? product.type() : "CROP",
            product.epaRegistrationNumber(),
            product.activeIngredients(),
            product.reiHours(),
            product.phiDays(),
            isLocalOnly != null ? isLocalOnly : false,
            product.adminNotes()
        );

        return repository.save(secureProduct);
    }

    public Product update(Product product) {
        return repository.save(product);
    }

    public Optional<Product> getById(UUID id) {
        return repository.findById(id);
    }

    public List<Product> getAll() {
        return repository.getAll();
    }
}
