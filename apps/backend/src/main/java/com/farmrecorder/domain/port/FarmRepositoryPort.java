package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Farm;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface FarmRepositoryPort {
    Farm save(Farm farm);
    Optional<Farm> findById(UUID id);
    List<Farm> getByOwnerId(String ownerId);
    List<Farm> getAll();
    List<Farm> getAssignedFarms(String email);
    void deleteById(UUID id);
}
