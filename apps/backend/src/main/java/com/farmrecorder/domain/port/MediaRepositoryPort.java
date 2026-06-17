package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Media;
import java.util.List;
import java.util.UUID;

public interface MediaRepositoryPort {
    Media save(Media media);
    List<Media> findByActivityLogId(UUID activityLogId);
}
