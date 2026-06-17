package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.Location;
import com.farmrecorder.domain.port.LocationRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.LocationMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class LocationRepositoryAdapter implements LocationRepositoryPort, PanacheRepository<LocationEntity> {

    private final LocationMapper mapper;

    @Inject
    public LocationRepositoryAdapter(LocationMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public Location save(Location location) {
        LocationEntity entity = mapper.toEntity(location);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<Location> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<Location> getAll() {
        return listAll().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void deleteById(UUID id) {
        delete("id", id);
    }
}
