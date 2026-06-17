package com.farmrecorder.infrastructure.weather;

import com.farmrecorder.domain.model.WeatherDetails;
import com.farmrecorder.domain.port.WeatherGatewayPort;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

@ApplicationScoped
public class WeatherAdapter implements WeatherGatewayPort {

    @RestClient
    OpenMeteoClient openMeteoClient;

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    public WeatherDetails fetchHistoricalWeather(Double lat, Double lng, Instant timestamp) {
        try {
            OpenMeteoResponse response = openMeteoClient.getForecast(
                lat, lng, "temperature_2m,wind_speed_10m,wind_direction_10m", 7
            );

            if (response == null || response.hourly == null || response.hourly.time == null || response.hourly.time.isEmpty()) {
                return null;
            }

            List<String> times = response.hourly.time;
            long minDiffSeconds = Long.MAX_VALUE;
            int closestIndex = -1;

            for (int i = 0; i < times.size(); i++) {
                LocalDateTime localDateTime = LocalDateTime.parse(times.get(i), FORMATTER);
                Instant hourInstant = localDateTime.toInstant(ZoneOffset.UTC);
                long diff = Math.abs(ChronoUnit.SECONDS.between(timestamp, hourInstant));
                if (diff < minDiffSeconds) {
                    minDiffSeconds = diff;
                    closestIndex = i;
                }
            }

            if (closestIndex != -1) {
                Double temp = response.hourly.temperature2m.get(closestIndex);
                Double windSpeed = response.hourly.windSpeed10m.get(closestIndex);
                Double windDirDegrees = response.hourly.windDirection10m.get(closestIndex);
                String windDir = getCardinalDirection(windDirDegrees);
                return new WeatherDetails(windSpeed, windDir, temp);
            }
        } catch (Exception e) {
            System.err.println("Failed to fetch historical weather: " + e.getMessage());
        }
        return null;
    }

    private String getCardinalDirection(Double degrees) {
        if (degrees == null) return "CALM";
        String[] directions = {"N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"};
        int index = (int) Math.round(((degrees % 360) / 22.5));
        return directions[index % 16];
    }
}
