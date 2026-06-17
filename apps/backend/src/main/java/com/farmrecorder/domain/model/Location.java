package com.farmrecorder.domain.model;

import java.util.UUID;

public record Location(
    UUID id,
    String gln,
    String name,
    String type,
    String geoJsonPolygon
) {}
