package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Worker;
import com.farmrecorder.infrastructure.persistence.WorkerEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "jakarta-cdi")
public interface WorkerMapper {

    @Mapping(target = "id", source = "id")
    Worker toDomain(WorkerEntity entity);

    @Mapping(target = "id", source = "id")
    WorkerEntity toEntity(Worker domain);
}
