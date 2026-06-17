package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Task;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface TaskRepositoryPort {
    Task save(Task task);
    Optional<Task> findById(UUID id);
    List<Task> getByFarmId(UUID farmId);
    List<Task> getByAssignedUser(String username);
}
