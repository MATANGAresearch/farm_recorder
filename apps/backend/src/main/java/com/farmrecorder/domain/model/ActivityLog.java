package com.farmrecorder.domain.model;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record ActivityLog(
    UUID id,
    @NotNull(message = "Timestamp is required")
    Instant timestamp,
    String userId,
    @NotNull(message = "Location ID is required")
    UUID locationId,
    UUID productId,
    UUID taskId,
    @NotNull(message = "Activity type is required")
    ActivityType type,
    String notes,
    Double gpsLat,
    Double gpsLng,
    Instant startTime,
    Instant endTime,
    UUID batchId,
    Integer quantity,
    BigDecimal unitPrice,
    BigDecimal totalPrice,
    String customerName,
    String customerPhone,
    String customerEmail,
    String chemicalLotNumber,
    Instant chemicalExpirationDate,
    String applicationRate,
    BigDecimal totalQuantityApplied,
    Double weatherWindSpeed,
    String weatherWindDirection,
    Double weatherTemperature,
    String applicatorLicense,
    Boolean isManualInput,
    String manualInputComments,
    String verificationStatus,
    String verifiedBy,
    Instant verifiedAt,
    Instant reiEndTime
) {}
