package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Task;
import com.farmrecorder.infrastructure.persistence.TaskEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface TaskMapper {
    Task toDomain(TaskEntity entity);
    TaskEntity toEntity(Task domain);
}
