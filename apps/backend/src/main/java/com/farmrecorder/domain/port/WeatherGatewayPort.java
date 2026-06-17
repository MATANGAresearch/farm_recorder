package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.WeatherDetails;
import java.time.Instant;

public interface WeatherGatewayPort {
    WeatherDetails fetchHistoricalWeather(Double lat, Double lng, Instant timestamp);
}
