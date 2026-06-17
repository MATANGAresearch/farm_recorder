package com.farmrecorder.application;

import com.farmrecorder.domain.model.HarvestBatch;
import com.farmrecorder.domain.port.HarvestBatchRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class HarvestBatchService {

    private final HarvestBatchRepositoryPort repository;

    @Inject
    public HarvestBatchService(HarvestBatchRepositoryPort repository) {
        this.repository = repository;
    }

    public List<HarvestBatch> getAvailableByProductId(UUID productId) {
        return repository.findAvailableByProductId(productId);
    }
}
