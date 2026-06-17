package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.port.ActivityLogRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.ActivityLogMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class ActivityLogRepositoryAdapter implements ActivityLogRepositoryPort, PanacheRepository<ActivityLogEntity> {

    private final ActivityLogMapper mapper;

    @Inject
    public ActivityLogRepositoryAdapter(ActivityLogMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public ActivityLog save(ActivityLog activityLog) {
        ActivityLogEntity entity = mapper.toEntity(activityLog);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<ActivityLog> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<ActivityLog> findByLocationId(UUID locationId) {
        return find("locationId", locationId).list().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    public Optional<ActivityLog> findByTaskId(UUID taskId) {
        return find("taskId", taskId).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    @Transactional
    public void deleteById(UUID id) {
        delete("id", id);
    }
}
