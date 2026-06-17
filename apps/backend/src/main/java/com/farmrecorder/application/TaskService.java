package com.farmrecorder.application;

import com.farmrecorder.domain.model.Task;
import com.farmrecorder.domain.model.TaskStatus;
import com.farmrecorder.domain.port.TaskRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class TaskService {

    private final TaskRepositoryPort repository;

    @Inject
    public TaskService(TaskRepositoryPort repository) {
        this.repository = repository;
    }

    public Task create(Task task) {
        return repository.save(task);
    }

    public Optional<Task> getById(UUID id) {
        return repository.findById(id);
    }

    public List<Task> getByFarmId(UUID farmId) {
        return repository.getByFarmId(farmId);
    }

    public List<Task> getByAssignedUser(String username) {
        return repository.getByAssignedUser(username);
    }

    @Transactional
    public Task updateStatus(UUID id, TaskStatus newStatus) {
        Task task = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Task not found with ID: " + id));
        Task updatedTask = new Task(
                task.id(),
                task.farmId(),
                task.assignedTo(),
                task.title(),
                task.description(),
                newStatus,
                task.dueDate()
        );
        return repository.save(updatedTask);
    }
}
