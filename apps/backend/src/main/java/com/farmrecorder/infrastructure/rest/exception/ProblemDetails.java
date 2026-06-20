package com.farmrecorder.infrastructure.rest.exception;

import java.util.List;

public record ProblemDetails(
    String title,
    int status,
    String detail,
    String instance,
    String correlationId,
    List<Violation> violations
) {
    public record Violation(String field, String message) {}
}
