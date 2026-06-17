package com.farmrecorder.application;

import com.farmrecorder.domain.model.Media;
import com.farmrecorder.domain.port.MediaRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class MediaService {

    private final MediaRepositoryPort repository;

    @Inject
    public MediaService(MediaRepositoryPort repository) {
        this.repository = repository;
    }

    public Media create(Media media) {
        return repository.save(media);
    }

    public List<Media> getByActivityLogId(UUID activityLogId) {
        return repository.findByActivityLogId(activityLogId);
    }
}
