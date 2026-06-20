package com.farmrecorder.domain.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.util.UUID;

public record Product(
    UUID id,
    @NotBlank(message = "GTIN is required")
    @Pattern(regexp = "^\\d{8,14}$", message = "GTIN must be a numeric string between 8 and 14 digits")
    String gtin,
    @NotBlank(message = "Product name is required")
    String name,
    String variety,
    String batchPrefix,
    BigDecimal defaultUnitPrice,
    @NotBlank(message = "Product type is required")
    String type,
    String epaRegistrationNumber,
    String activeIngredients,
    Integer reiHours,
    Integer phiDays,
    Boolean isLocalOnly,
    String adminNotes
) {}
