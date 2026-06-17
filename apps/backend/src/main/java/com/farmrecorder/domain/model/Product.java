package com.farmrecorder.domain.model;

import java.math.BigDecimal;
import java.util.UUID;

public record Product(
    UUID id,
    String gtin,
    String name,
    String variety,
    String batchPrefix,
    BigDecimal defaultUnitPrice,
    String type,
    String epaRegistrationNumber,
    String activeIngredients,
    Integer reiHours,
    Integer phiDays,
    Boolean isLocalOnly,
    String adminNotes
) {}
