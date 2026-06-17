package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Product;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProductRepositoryPort {
    Product save(Product product);
    Optional<Product> findById(UUID id);
    Optional<Product> findByGtin(String gtin);
    List<Product> getAll();
}
