package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Media;
import com.farmrecorder.domain.port.MediaRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.MediaMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class MediaRepositoryAdapter implements MediaRepositoryPort, PanacheRepository<MediaEntity> {

    private final MediaMapper mapper;

    @Inject
    public MediaRepositoryAdapter(MediaMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Media save(Media media) {
        MediaEntity entity = mapper.toEntity(media);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public List<Media> findByActivityLogId(UUID activityLogId) {
        return find("activityLogId", activityLogId).list().stream().map(mapper::toDomain).collect(Collectors.toList());
    }
}
