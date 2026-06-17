package com.farmrecorder.infrastructure.weather;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class OpenMeteoResponse {
    public Hourly hourly;

    public static class Hourly {
        public List<String> time;
        
        @JsonProperty("temperature_2m")
        public List<Double> temperature2m;
        
        @JsonProperty("wind_speed_10m")
        public List<Double> windSpeed10m;
        
        @JsonProperty("wind_direction_10m")
        public List<Double> windDirection10m;
    }
}
