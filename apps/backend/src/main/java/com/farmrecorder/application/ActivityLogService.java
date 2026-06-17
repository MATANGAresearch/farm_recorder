package com.farmrecorder.application;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.model.ActivityType;
import com.farmrecorder.domain.model.HarvestBatch;
import com.farmrecorder.domain.model.HarvestBatchStatus;
import com.farmrecorder.domain.model.Product;
import com.farmrecorder.domain.model.Task;
import com.farmrecorder.domain.model.TaskStatus;
import com.farmrecorder.domain.port.ActivityLogRepositoryPort;
import com.farmrecorder.domain.port.EpcisGatewayPort;
import com.farmrecorder.domain.port.HarvestBatchRepositoryPort;
import com.farmrecorder.domain.port.InputBatchRepositoryPort;
import com.farmrecorder.domain.port.OpenSearchIndexerPort;
import com.farmrecorder.domain.port.ProductRepositoryPort;
import com.farmrecorder.domain.port.TaskRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@ApplicationScoped
public class ActivityLogService {

    private final ActivityLogRepositoryPort repository;
    private final EpcisGatewayPort epcisGateway;
    private final HarvestBatchRepositoryPort harvestBatchRepository;
    private final InputBatchRepositoryPort inputBatchRepository;
    private final OpenSearchIndexerPort openSearchIndexer;
    private final ProductRepositoryPort productRepository;
    private final TaskRepositoryPort taskRepository;
    private final WeatherIntegrationService weatherIntegrationService;

    @Inject
    public ActivityLogService(ActivityLogRepositoryPort repository,
                              EpcisGatewayPort epcisGateway,
                              HarvestBatchRepositoryPort harvestBatchRepository,
                              InputBatchRepositoryPort inputBatchRepository,
                              OpenSearchIndexerPort openSearchIndexer,
                              ProductRepositoryPort productRepository,
                              TaskRepositoryPort taskRepository,
                              WeatherIntegrationService weatherIntegrationService) {
        this.repository = repository;
        this.epcisGateway = epcisGateway;
        this.harvestBatchRepository = harvestBatchRepository;
        this.inputBatchRepository = inputBatchRepository;
        this.openSearchIndexer = openSearchIndexer;
        this.productRepository = productRepository;
        this.taskRepository = taskRepository;
        this.weatherIntegrationService = weatherIntegrationService;
    }

    public ActivityLog create(ActivityLog activityLog) {
        return create(activityLog, false);
    }

    public ActivityLog create(ActivityLog activityLog, boolean isSupervisor) {
        String verificationStatus = activityLog.verificationStatus();
        Instant reiEndTime = activityLog.reiEndTime();

        if (activityLog.type() == ActivityType.SPRAYING) {
            int reiHours = 0;
            if (activityLog.productId() != null) {
                Optional<Product> productOpt = productRepository.findById(activityLog.productId());
                if (productOpt.isPresent()) {
                    Product product = productOpt.get();
                    if (product.reiHours() != null) {
                        reiHours = product.reiHours();
                    }
                }
            }

            if (reiEndTime == null && reiHours > 0) {
                reiEndTime = activityLog.timestamp().plus(reiHours, ChronoUnit.HOURS);
            }

            if (verificationStatus == null || "PENDING".equalsIgnoreCase(verificationStatus)) {
                if (isSupervisor) {
                    verificationStatus = "VERIFIED";
                } else {
                    verificationStatus = "PENDING";
                }
            }
        } else {
            if (verificationStatus == null) {
                verificationStatus = "VERIFIED";
            }
        }

        ActivityLog secureLog = new ActivityLog(
            activityLog.id(),
            activityLog.timestamp(),
            activityLog.userId(),
            activityLog.locationId(),
            activityLog.productId(),
            activityLog.taskId(),
            activityLog.type(),
            activityLog.notes(),
            activityLog.gpsLat(),
            activityLog.gpsLng(),
            activityLog.startTime(),
            activityLog.endTime(),
            activityLog.batchId(),
            activityLog.quantity(),
            activityLog.unitPrice(),
            activityLog.totalPrice(),
            activityLog.customerName(),
            activityLog.customerPhone(),
            activityLog.customerEmail(),
            activityLog.chemicalLotNumber(),
            activityLog.chemicalExpirationDate(),
            activityLog.applicationRate(),
            activityLog.totalQuantityApplied(),
            activityLog.weatherWindSpeed(),
            activityLog.weatherWindDirection(),
            activityLog.weatherTemperature(),
            activityLog.applicatorLicense(),
            activityLog.isManualInput() != null ? activityLog.isManualInput() : false,
            activityLog.manualInputComments(),
            verificationStatus,
            activityLog.verifiedBy(),
            activityLog.verifiedAt(),
            reiEndTime
        );

        ActivityLog saved = repository.save(secureLog);

        // Handle Harvest Batch creation or depletion
        if (saved.type() == ActivityType.HARVESTING && saved.quantity() != null && saved.quantity() > 0) {
            String batchNumber = String.format("%s-%s-%03d",
                saved.productId() != null ? saved.productId().toString().substring(0, 8).toUpperCase() : "BATCH",
                DateTimeFormatter.ofPattern("yyyyMMdd").withZone(ZoneOffset.UTC).format(Instant.now()),
                (int)(Math.random() * 1000));

            HarvestBatch newBatch = new HarvestBatch(
                IdGenerator.generate(),
                saved.productId(),
                saved.locationId(),
                saved.userId(),
                saved.timestamp(),
                batchNumber,
                saved.quantity(),
                saved.quantity(),
                HarvestBatchStatus.AVAILABLE
            );
            harvestBatchRepository.save(newBatch);
        } else if (saved.type() == ActivityType.DIRECT_SALE && saved.batchId() != null && saved.quantity() != null) {
            boolean success = harvestBatchRepository.decrementRemainingQuantity(saved.batchId(), saved.quantity());
            if (!success) {
                throw new IllegalArgumentException("Insufficient quantity in harvest batch or batch not found.");
            }
        } else if (saved.type() == ActivityType.SPRAYING && saved.chemicalLotNumber() != null && saved.totalQuantityApplied() != null) {
            if (saved.productId() != null) {
                Optional<Product> productOpt = productRepository.findById(saved.productId());
                if (productOpt.isPresent() && productOpt.get().gtin() != null) {
                    inputBatchRepository.decrementRemainingQuantity(
                        productOpt.get().gtin(),
                        saved.chemicalLotNumber(),
                        saved.totalQuantityApplied()
                    );
                }
            }
        }

        // Trigger automatic verification task creation for supervisors
        if (saved.type() == ActivityType.SPRAYING && "PENDING".equals(saved.verificationStatus())) {
            UUID farmId = null;
            if (saved.taskId() != null) {
                Optional<Task> taskOpt = taskRepository.findById(saved.taskId());
                if (taskOpt.isPresent()) {
                    farmId = taskOpt.get().farmId();
                }
            }
            if (farmId == null) {
                farmId = UUID.fromString("019ecc19-b6be-76d9-b997-5e89f6c0e35a");
            }

            Task verificationTask = new Task(
                IdGenerator.generate(),
                farmId,
                "supervisor",
                "Verify Spraying Activity",
                "Please verify the spraying activity logged by " + saved.userId() + " at location " + saved.locationId() + " (Activity Log ID: " + saved.id() + ").",
                TaskStatus.PENDING,
                Instant.now().plus(2, ChronoUnit.DAYS)
            );
            taskRepository.save(verificationTask);
        }

        // Trigger background weather fetching
        if (saved.type() == ActivityType.SPRAYING &&
            saved.gpsLat() != null && saved.gpsLng() != null &&
            saved.weatherWindSpeed() == null) {
            weatherIntegrationService.backfillWeather(saved.id());
        }

        // Publish to EPCIS
        epcisGateway.publishEvent(saved);

        // Index in OpenSearch
        openSearchIndexer.indexActivity(saved);

        return saved;
    }

    public ActivityLog update(ActivityLog activityLog) {
        ActivityLog saved = repository.save(activityLog);
        openSearchIndexer.indexActivity(saved);
        return saved;
    }

    public Optional<ActivityLog> getById(UUID id) {
        return repository.findById(id);
    }

    public Optional<ActivityLog> getByTaskId(UUID taskId) {
        return repository.findByTaskId(taskId);
    }

    public List<ActivityLog> getByLocationId(UUID locationId) {
        return repository.findByLocationId(locationId);
    }
}
