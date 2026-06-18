package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.domain.port.FarmRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.FarmMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class FarmRepositoryAdapter implements FarmRepositoryPort, PanacheRepository<FarmEntity> {

    private final FarmMapper mapper;

    @Inject
    public FarmRepositoryAdapter(FarmMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Farm save(Farm farm) {
        FarmEntity entity = mapper.toEntity(farm);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<Farm> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<Farm> getByOwnerId(String ownerId) {
        return find("ownerId", ownerId).list().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<Farm> getAll() {
        return listAll().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<Farm> getAssignedFarms(String email) {
        return find("id in (select fw.farmId from FarmWorkerEntity fw where fw.workerEmail = ?1)", email)
                .list().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void deleteById(UUID id) {
        delete("id", id);
    }
}
