package com.farmrecorder.domain.model;

import java.util.UUID;

public record Farm(
    UUID id,
    String name,
    String ownerId
) {}
