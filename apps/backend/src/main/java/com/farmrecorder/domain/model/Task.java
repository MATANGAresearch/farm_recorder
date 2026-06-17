package com.farmrecorder.domain.model;

import java.time.Instant;
import java.util.UUID;

public record Task(
    UUID id,
    UUID farmId,
    String assignedTo,
    String title,
    String description,
    TaskStatus status,
    Instant dueDate
) {}
