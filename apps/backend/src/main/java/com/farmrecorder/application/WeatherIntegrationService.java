package com.farmrecorder.application;

import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.model.WeatherDetails;
import com.farmrecorder.domain.port.ActivityLogRepositoryPort;
import com.farmrecorder.domain.port.WeatherGatewayPort;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.context.ManagedExecutor;
import jakarta.inject.Inject;
import org.jboss.logging.Logger;
import java.util.UUID;

@ApplicationScoped
public class WeatherIntegrationService {

    private static final Logger LOG = Logger.getLogger(WeatherIntegrationService.class);

    private final ManagedExecutor executor;
    private final WeatherGatewayPort weatherGateway;
    private final ActivityLogRepositoryPort repository;

    @Inject
    public WeatherIntegrationService(ManagedExecutor executor,
                                     WeatherGatewayPort weatherGateway,
                                     ActivityLogRepositoryPort repository) {
        this.executor = executor;
        this.weatherGateway = weatherGateway;
        this.repository = repository;
    }

    public void backfillWeather(UUID logId) {
        executor.runAsync(() -> {
            try {
                repository.findById(logId).ifPresent(log -> {
                    if (log.gpsLat() != null && log.gpsLng() != null && log.weatherWindSpeed() == null) {
                        WeatherDetails details = weatherGateway.fetchHistoricalWeather(
                            log.gpsLat(), log.gpsLng(), log.timestamp()
                        );
                        if (details != null) {
                            ActivityLog updatedLog = new ActivityLog(
                                log.id(),
                                log.timestamp(),
                                log.userId(),
                                log.locationId(),
                                log.productId(),
                                log.taskId(),
                                log.type(),
                                log.notes(),
                                log.gpsLat(),
                                log.gpsLng(),
                                log.startTime(),
                                log.endTime(),
                                log.batchId(),
                                log.quantity(),
                                log.unitPrice(),
                                log.totalPrice(),
                                log.customerName(),
                                log.customerPhone(),
                                log.customerEmail(),
                                log.chemicalLotNumber(),
                                log.chemicalExpirationDate(),
                                log.applicationRate(),
                                log.totalQuantityApplied(),
                                details.windSpeed(),
                                details.windDirection(),
                                details.temperature(),
                                log.applicatorLicense(),
                                log.isManualInput(),
                                log.manualInputComments(),
                                log.verificationStatus(),
                                log.verifiedBy(),
                                log.verifiedAt(),
                                log.reiEndTime()
                            );
                            repository.save(updatedLog);
                        }
                    }
                });
            } catch (Exception e) {
                LOG.error("Error backfilling weather for log " + logId, e);
            }
        });
    }
}
