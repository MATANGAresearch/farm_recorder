package com.farmrecorder.application;

import com.farmrecorder.domain.model.Location;
import com.farmrecorder.domain.port.LocationRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class LocationService {

    private final LocationRepositoryPort repository;

    @Inject
    public LocationService(LocationRepositoryPort repository) {
        this.repository = repository;
    }

    public Location create(Location location) {
        return repository.save(location);
    }

    public Optional<Location> getById(UUID id) {
        return repository.findById(id);
    }

    public List<Location> getAll() {
        return repository.getAll();
    }

    public void delete(UUID id) {
        repository.deleteById(id);
    }
}
