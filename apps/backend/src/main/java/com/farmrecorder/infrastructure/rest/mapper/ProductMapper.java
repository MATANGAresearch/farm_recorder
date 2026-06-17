package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Product;
import com.farmrecorder.infrastructure.persistence.ProductEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface ProductMapper {
    Product toDomain(ProductEntity entity);
    ProductEntity toEntity(Product domain);
}
