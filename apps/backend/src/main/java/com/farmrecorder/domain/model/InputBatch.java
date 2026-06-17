package com.farmrecorder.domain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record InputBatch(
    UUID id,
    String gtin,
    String lotNumber,
    UUID productId,
    BigDecimal initialQuantity,
    BigDecimal remainingQuantity,
    Instant expirationDate,
    String unit,
    Instant createdAt
) {}
