package com.farmrecorder.domain.model;

import java.time.Instant;
import java.util.UUID;

public record Media(
    UUID id,
    UUID activityLogId,
    String mediaUrl,
    MediaType mediaType,
    Double capturedGpsLat,
    Double capturedGpsLng,
    Instant timestamp
) {}
