package com.farmrecorder.infrastructure.rest.exception;

import jakarta.annotation.Priority;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;
import org.jboss.logging.Logger;
import org.jboss.logging.MDC;

@Provider
@Priority(1)
public class GlobalExceptionMapper implements ExceptionMapper<Throwable> {

    private static final Logger LOG = Logger.getLogger(GlobalExceptionMapper.class);
    private static final String MDC_KEY = "correlationId";

    @Context
    UriInfo uriInfo;

    @Override
    public Response toResponse(Throwable exception) {
        String correlationId = (String) MDC.get(MDC_KEY);
        String path = uriInfo != null && uriInfo.getRequestUri() != null ? uriInfo.getRequestUri().getPath() : "";

        if (exception instanceof WebApplicationException) {
            WebApplicationException wae = (WebApplicationException) exception;
            int status = wae.getResponse().getStatus();

            LOG.infof(exception, "WebApplicationException on path %s. Correlation ID: %s. Status: %d",
                    path, correlationId, status);

            ProblemDetails problem = new ProblemDetails(
                    Response.Status.fromStatusCode(status) != null 
                        ? Response.Status.fromStatusCode(status).getReasonPhrase() 
                        : "HTTP Error",
                    status,
                    wae.getMessage() != null ? wae.getMessage() : exception.getMessage(),
                    path,
                    correlationId,
                    null
            );

            return Response.status(status)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(problem)
                    .build();
        }

        // General unhandled exceptions
        LOG.errorf(exception, "Unhandled exception on path %s. Correlation ID: %s", path, correlationId);

        ProblemDetails problem = new ProblemDetails(
                "Internal Server Error",
                Response.Status.INTERNAL_SERVER_ERROR.getStatusCode(),
                exception.getMessage() != null ? exception.getMessage() : "An unexpected error occurred.",
                path,
                correlationId,
                null
        );

        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                .type(MediaType.APPLICATION_JSON)
                .entity(problem)
                .build();
    }
}
