package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.HarvestBatch;
import com.farmrecorder.infrastructure.persistence.HarvestBatchEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface HarvestBatchMapper {
    HarvestBatch toDomain(HarvestBatchEntity entity);
    HarvestBatchEntity toEntity(HarvestBatch domain);
}
