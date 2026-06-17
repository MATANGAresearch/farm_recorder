package com.farmrecorder.infrastructure.rest.mapper;

import com.farmrecorder.domain.model.Media;
import com.farmrecorder.infrastructure.persistence.MediaEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface MediaMapper {
    Media toDomain(MediaEntity entity);
    MediaEntity toEntity(Media domain);
}
