package com.farmrecorder.domain.model;

import java.util.UUID;

public record Worker(
    UUID id,
    String username,
    String fullName,
    String applicatorLicense
) {}
