package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Task;
import com.farmrecorder.domain.port.TaskRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.TaskMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class TaskRepositoryAdapter implements TaskRepositoryPort, PanacheRepository<TaskEntity> {

    private final TaskMapper mapper;

    @Inject
    public TaskRepositoryAdapter(TaskMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Task save(Task task) {
        TaskEntity entity = mapper.toEntity(task);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
            persist(entity);
        } else {
            entity = getEntityManager().merge(entity);
        }
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<Task> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<Task> getByFarmId(UUID farmId) {
        return find("farmId", farmId).list().stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Task> getByAssignedUser(String username) {
        return find("assignedTo", username).list().stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }
}
