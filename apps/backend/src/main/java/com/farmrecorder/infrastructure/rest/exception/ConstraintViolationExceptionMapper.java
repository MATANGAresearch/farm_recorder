package com.farmrecorder.infrastructure.rest.exception;

import jakarta.annotation.Priority;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;
import org.jboss.logging.Logger;
import org.jboss.logging.MDC;

import java.util.List;
import java.util.stream.Collectors;

@Provider
@Priority(1)
public class ConstraintViolationExceptionMapper implements ExceptionMapper<ConstraintViolationException> {

    private static final Logger LOG = Logger.getLogger(ConstraintViolationExceptionMapper.class);
    private static final String MDC_KEY = "correlationId";

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(ConstraintViolationException exception) {
        String correlationId = (String) MDC.get(MDC_KEY);
        String path = uriInfo != null && uriInfo.getRequestUri() != null ? uriInfo.getRequestUri().getPath() : "";

        List<ProblemDetails.Violation> violations = exception.getConstraintViolations().stream()
                .map(v -> new ProblemDetails.Violation(v.getPropertyPath().toString(), v.getMessage()))
                .collect(Collectors.toList());

        LOG.warnf("Validation failed for request on path %s. Correlation ID: %s. Violations: %s",
                path, correlationId, violations);

        ProblemDetails problem = new ProblemDetails(
                "Validation Failed",
                Response.Status.BAD_REQUEST.getStatusCode(),
                "The request entity contains validation errors.",
                path,
                correlationId,
                violations
        );

        return Response.status(Response.Status.BAD_REQUEST)
                .type(MediaType.APPLICATION_JSON)
                .entity(problem)
                .build();
    }
}
