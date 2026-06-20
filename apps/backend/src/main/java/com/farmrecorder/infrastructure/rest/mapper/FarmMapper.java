package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.infrastructure.persistence.FarmEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "jakarta-cdi")
public interface FarmMapper {

    @Mapping(target = "id", source = "id")
    Farm toDomain(FarmEntity entity);

    @Mapping(target = "id", source = "id")
    FarmEntity toEntity(Farm domain);
}
