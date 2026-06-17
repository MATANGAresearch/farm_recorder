package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.Location;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface LocationRepositoryPort {
    Location save(Location location);
    Optional<Location> findById(UUID id);
    List<Location> getAll();
    void deleteById(UUID id);
}
