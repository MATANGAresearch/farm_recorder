package com.farmrecorder.application;

import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.model.ActivityType;
import com.farmrecorder.domain.model.HarvestBatch;
import com.farmrecorder.domain.model.HarvestBatchStatus;
import com.farmrecorder.domain.port.ActivityLogRepositoryPort;
import com.farmrecorder.domain.port.EpcisGatewayPort;
import com.farmrecorder.domain.port.HarvestBatchRepositoryPort;
import com.farmrecorder.domain.port.InputBatchRepositoryPort;
import com.farmrecorder.domain.model.Product;
import io.quarkus.test.InjectMock;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@QuarkusTest
class ActivityLogServiceTest {

    @Inject
    ActivityLogService activityLogService;

    @InjectMock
    ActivityLogRepositoryPort activityLogRepository;

    @InjectMock
    EpcisGatewayPort epcisGateway;

    @InjectMock
    HarvestBatchRepositoryPort harvestBatchRepository;

    @InjectMock
    com.farmrecorder.domain.port.ProductRepositoryPort productRepository;

    @InjectMock
    com.farmrecorder.domain.port.TaskRepositoryPort taskRepository;

    @InjectMock
    WeatherIntegrationService weatherIntegrationService;

    @InjectMock
    InputBatchRepositoryPort inputBatchRepository;

    @Test
    void testCreateHarvestingActivity_CreatesHarvestBatch() {
        // Arrange
        UUID locationId = UUID.randomUUID();
        UUID productId = UUID.randomUUID();
        ActivityLog inputLog = new ActivityLog(
                null, Instant.now(), "user-1", locationId, productId, null,
                ActivityType.HARVESTING, "Test harvest", 32.0, 35.0,
                Instant.now(), Instant.now(), null, 50, null, null, null, null, null,
                null, null, null, null, null, null, null, null, false, null, "VERIFIED", null, null, null
        );

        when(activityLogRepository.save(any(ActivityLog.class))).thenAnswer(invocation -> {
            ActivityLog log = invocation.getArgument(0);
            return new ActivityLog(UUID.randomUUID(), log.timestamp(), log.userId(), log.locationId(),
                    log.productId(), log.taskId(), log.type(), log.notes(), log.gpsLat(), log.gpsLng(),
                    log.startTime(), log.endTime(), log.batchId(), log.quantity(), log.unitPrice(),
                    log.totalPrice(), log.customerName(), log.customerPhone(), log.customerEmail(),
                    log.chemicalLotNumber(), log.chemicalExpirationDate(), log.applicationRate(),
                    log.totalQuantityApplied(), log.weatherWindSpeed(), log.weatherWindDirection(),
                    log.weatherTemperature(), log.applicatorLicense(), log.isManualInput(),
                    log.manualInputComments(), log.verificationStatus(), log.verifiedBy(),
                    log.verifiedAt(), log.reiEndTime());
        });

        // Act
        ActivityLog result = activityLogService.create(inputLog);

        // Assert
        assertNotNull(result.id());
        verify(activityLogRepository).save(any(ActivityLog.class));
        verify(epcisGateway).publishEvent(any(ActivityLog.class));
        
        ArgumentCaptor<HarvestBatch> batchCaptor = ArgumentCaptor.forClass(HarvestBatch.class);
        verify(harvestBatchRepository).save(batchCaptor.capture());
        
        HarvestBatch savedBatch = batchCaptor.getValue();
        assertEquals(50, savedBatch.initialQuantity());
        assertEquals(50, savedBatch.remainingQuantity());
        assertEquals(HarvestBatchStatus.AVAILABLE, savedBatch.status());
        assertNotNull(savedBatch.batchNumber());
    }

    @Test
    void testCreateDirectSaleActivity_DecrementsBatchQuantity() {
        // Arrange
        UUID batchId = UUID.randomUUID();
        ActivityLog inputLog = new ActivityLog(
                null, Instant.now(), "user-1", UUID.randomUUID(), UUID.randomUUID(), null,
                ActivityType.DIRECT_SALE, "Direct sale", 32.0, 35.0,
                Instant.now(), Instant.now(), batchId, 10, new BigDecimal("2.50"), new BigDecimal("25.00"), "John Doe", "123456789", "john@example.com",
                null, null, null, null, null, null, null, null, false, null, "VERIFIED", null, null, null
        );

        when(activityLogRepository.save(any(ActivityLog.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(harvestBatchRepository.decrementRemainingQuantity(eq(batchId), eq(10))).thenReturn(true);

        // Act
        ActivityLog result = activityLogService.create(inputLog);

        // Assert
        assertNotNull(result);
        verify(harvestBatchRepository).decrementRemainingQuantity(batchId, 10);
        verify(epcisGateway).publishEvent(any(ActivityLog.class));
    }

    @Test
    void testCreateDirectSaleActivity_ThrowsExceptionOnInsufficientQuantity() {
        // Arrange
        UUID batchId = UUID.randomUUID();
        ActivityLog inputLog = new ActivityLog(
                null, Instant.now(), "user-1", UUID.randomUUID(), UUID.randomUUID(), null,
                ActivityType.DIRECT_SALE, "Direct sale", 32.0, 35.0,
                Instant.now(), Instant.now(), batchId, 10, new BigDecimal("2.50"), new BigDecimal("25.00"), "John Doe", "123456789", "john@example.com",
                null, null, null, null, null, null, null, null, false, null, "VERIFIED", null, null, null
        );

        when(activityLogRepository.save(any(ActivityLog.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(harvestBatchRepository.decrementRemainingQuantity(eq(batchId), eq(10))).thenReturn(false);

        // Act & Assert
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            activityLogService.create(inputLog);
        });
        assertEquals("Insufficient quantity in harvest batch or batch not found.", exception.getMessage());
    }

    @Test
    void testCreateSprayingActivity_DecrementsInputBatchQuantity() {
        // Arrange
        UUID productId = UUID.randomUUID();
        String chemicalLotNumber = "LOT-12345";
        BigDecimal totalQuantityApplied = new BigDecimal("10.50");
        String gtin = "00871234567890";

        Product mockProduct = new Product(productId, gtin, "Neem Oil", "CropShield", null, null, "CHEMICAL", null, null, null, null, null, null);
        when(productRepository.findById(productId)).thenReturn(java.util.Optional.of(mockProduct));

        ActivityLog inputLog = new ActivityLog(
                null, Instant.now(), "user-1", UUID.randomUUID(), productId, null,
                ActivityType.SPRAYING, "Spraying activity", 32.0, 35.0,
                null, null, null, null, null, null, null, null, null,
                chemicalLotNumber, Instant.now().plusSeconds(86400), "1.5 L/ha", totalQuantityApplied,
                5.0, "N", 25.0, "LIC-998877", false, null, "PENDING", null, null, null
        );

        when(activityLogRepository.save(any(ActivityLog.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(inputBatchRepository.decrementRemainingQuantity(eq(gtin), eq(chemicalLotNumber), eq(totalQuantityApplied))).thenReturn(true);

        // Act
        ActivityLog result = activityLogService.create(inputLog);

        // Assert
        assertNotNull(result);
        verify(inputBatchRepository).decrementRemainingQuantity(gtin, chemicalLotNumber, totalQuantityApplied);
        verify(epcisGateway).publishEvent(any(ActivityLog.class));
    }
}
