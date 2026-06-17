package com.farmrecorder.domain.model;

import java.time.Instant;
import java.util.UUID;

public record HarvestBatch(
    UUID id,
    UUID productId,
    UUID locationId,
    String harvestedById,
    Instant harvestedAt,
    String batchNumber,
    int initialQuantity,
    int remainingQuantity,
    HarvestBatchStatus status
) {}
