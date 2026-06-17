package com.farmrecorder.domain.model;

public record WeatherDetails(
    Double windSpeed,
    String windDirection,
    Double temperature
) {}
