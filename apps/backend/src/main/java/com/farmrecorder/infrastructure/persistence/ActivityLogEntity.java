package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.domain.model.ActivityType;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "activity_logs")
public class ActivityLogEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(nullable = false)
    public Instant timestamp;

    @Column(name = "user_id", nullable = false)
    public String userId;

    @Column(name = "location_id", nullable = false)
    public UUID locationId;

    @Column(name = "product_id")
    public UUID productId;

    @Column(name = "task_id")
    public UUID taskId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public ActivityType type;

    @Column(columnDefinition = "TEXT")
    public String notes;

    @Column(name = "gps_lat")
    public Double gpsLat;

    @Column(name = "gps_lng")
    public Double gpsLng;

    @Column(name = "start_time")
    public Instant startTime;

    @Column(name = "end_time")
    public Instant endTime;

    @Column(name = "batch_id")
    public UUID batchId;

    @Column(name = "quantity")
    public Integer quantity;

    @Column(name = "unit_price", precision = 10, scale = 2)
    public BigDecimal unitPrice;

    @Column(name = "total_price", precision = 10, scale = 2)
    public BigDecimal totalPrice;

    @Column(name = "customer_name")
    public String customerName;

    @Column(name = "customer_phone")
    public String customerPhone;

    @Column(name = "customer_email")
    public String customerEmail;

    @Column(name = "chemical_lot_number")
    public String chemicalLotNumber;

    @Column(name = "chemical_expiration_date")
    public Instant chemicalExpirationDate;

    @Column(name = "application_rate")
    public String applicationRate;

    @Column(name = "total_quantity_applied", precision = 10, scale = 2)
    public BigDecimal totalQuantityApplied;

    @Column(name = "weather_wind_speed")
    public Double weatherWindSpeed;

    @Column(name = "weather_wind_direction")
    public String weatherWindDirection;

    @Column(name = "weather_temperature")
    public Double weatherTemperature;

    @Column(name = "applicator_license")
    public String applicatorLicense;

    @Column(name = "is_manual_input", nullable = false)
    public Boolean isManualInput;

    @Column(name = "manual_input_comments", columnDefinition = "TEXT")
    public String manualInputComments;

    @Column(name = "verification_status", nullable = false)
    public String verificationStatus;

    @Column(name = "verified_by")
    public String verifiedBy;

    @Column(name = "verified_at")
    public Instant verifiedAt;

    @Column(name = "rei_end_time")
    public Instant reiEndTime;
}
