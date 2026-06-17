package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.ActivityLog;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ActivityLogRepositoryPort {
    ActivityLog save(ActivityLog activityLog);
    Optional<ActivityLog> findById(UUID id);
    List<ActivityLog> findByLocationId(UUID locationId);
    Optional<ActivityLog> findByTaskId(UUID taskId);
    void deleteById(UUID id);
}

