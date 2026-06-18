package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Worker;
import com.farmrecorder.domain.port.WorkerRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.WorkerMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class WorkerRepositoryAdapter implements WorkerRepositoryPort, PanacheRepository<WorkerEntity> {

    private final WorkerMapper mapper;

    @Inject
    public WorkerRepositoryAdapter(WorkerMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Worker save(Worker worker) {
        WorkerEntity entity = mapper.toEntity(worker);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<Worker> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public Optional<Worker> findByUsername(String username) {
        return find("username", username).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<Worker> getAll() {
        return listAll().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void deleteById(UUID id) {
        delete("id", id);
    }
}
