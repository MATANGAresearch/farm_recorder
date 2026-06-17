package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.HarvestBatch;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface HarvestBatchRepositoryPort {
    HarvestBatch save(HarvestBatch batch);
    Optional<HarvestBatch> findById(UUID id);
    List<HarvestBatch> findAvailableByProductId(UUID productId);
    boolean decrementRemainingQuantity(UUID batchId, int quantityToDeduct);
}
