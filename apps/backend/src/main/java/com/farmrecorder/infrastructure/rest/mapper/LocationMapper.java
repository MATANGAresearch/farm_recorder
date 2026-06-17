package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Location;
import com.farmrecorder.infrastructure.persistence.LocationEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "cdi")
public interface LocationMapper {

    @Mapping(target = "id", source = "id")
    Location toDomain(LocationEntity entity);

    @Mapping(target = "id", source = "id")
    LocationEntity toEntity(Location domain);
}
