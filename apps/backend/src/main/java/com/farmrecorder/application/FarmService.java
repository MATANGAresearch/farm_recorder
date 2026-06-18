package com.farmrecorder.application;

import com.farmrecorder.domain.model.Farm;
import com.farmrecorder.domain.port.FarmRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class FarmService {

    private final FarmRepositoryPort repository;

    @Inject
    public FarmService(FarmRepositoryPort repository) {
        this.repository = repository;
    }

    public Farm create(Farm farm) {
        return repository.save(farm);
    }

    public Optional<Farm> getById(UUID id) {
        return repository.findById(id);
    }

    public List<Farm> getByOwner(String ownerId) {
        return repository.getByOwnerId(ownerId);
    }

    public List<Farm> getAssignedFarms(String email) {
        return repository.getAssignedFarms(email);
    }

    public List<Farm> getAll() {
        return repository.getAll();
    }

    public void delete(UUID id) {
        repository.deleteById(id);
    }
}
