package com.farmrecorder.application;

import com.farmrecorder.domain.model.Worker;
import com.farmrecorder.domain.port.WorkerRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class WorkerService {

    private final WorkerRepositoryPort repository;

    @Inject
    public WorkerService(WorkerRepositoryPort repository) {
        this.repository = repository;
    }

    public Worker create(Worker worker) {
        return repository.save(worker);
    }

    public Optional<Worker> getById(UUID id) {
        return repository.findById(id);
    }

    public Optional<Worker> getByUsername(String username) {
        return repository.findByUsername(username);
    }

    public List<Worker> getAll() {
        return repository.getAll();
    }

    public void delete(UUID id) {
        repository.deleteById(id);
    }
}
