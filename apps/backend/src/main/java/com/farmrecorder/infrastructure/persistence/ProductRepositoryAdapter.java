package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Product;
import com.farmrecorder.domain.port.ProductRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.ProductMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class ProductRepositoryAdapter implements ProductRepositoryPort, PanacheRepository<ProductEntity> {

    private final ProductMapper mapper;

    @Inject
    public ProductRepositoryAdapter(ProductMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Product save(Product product) {
        ProductEntity entity = mapper.toEntity(product);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<Product> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public Optional<Product> findByGtin(String gtin) {
        return find("gtin", gtin).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<Product> getAll() {
        return listAll().stream().map(mapper::toDomain).collect(Collectors.toList());
    }
}
