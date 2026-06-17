package com.farmrecorder.infrastructure.weather;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@RegisterRestClient(baseUri = "https://api.open-meteo.com")
@Path("/v1")
public interface OpenMeteoClient {

    @GET
    @Path("/forecast")
    OpenMeteoResponse getForecast(
        @QueryParam("latitude") Double latitude,
        @QueryParam("longitude") Double longitude,
        @QueryParam("hourly") String hourly,
        @QueryParam("past_days") Integer pastDays
    );
}
