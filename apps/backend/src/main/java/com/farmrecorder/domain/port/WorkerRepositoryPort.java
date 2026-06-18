package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Worker;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface WorkerRepositoryPort {
    Worker save(Worker worker);
    Optional<Worker> findById(UUID id);
    Optional<Worker> findByUsername(String username);
    List<Worker> getAll();
    void deleteById(UUID id);
}
