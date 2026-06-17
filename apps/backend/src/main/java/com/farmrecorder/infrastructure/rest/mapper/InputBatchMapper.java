package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.InputBatch;
import com.farmrecorder.infrastructure.persistence.InputBatchEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface InputBatchMapper {
    InputBatch toDomain(InputBatchEntity entity);
    InputBatchEntity toEntity(InputBatch domain);
}
