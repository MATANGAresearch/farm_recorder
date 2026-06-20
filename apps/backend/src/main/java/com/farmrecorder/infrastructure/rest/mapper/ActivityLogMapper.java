package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.infrastructure.persistence.ActivityLogEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "jakarta-cdi")
public interface ActivityLogMapper {
    ActivityLog toDomain(ActivityLogEntity entity);
    ActivityLogEntity toEntity(ActivityLog domain);
}
