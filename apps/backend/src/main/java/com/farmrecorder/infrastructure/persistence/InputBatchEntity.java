package com.farmrecorder.infrastructure.persistence;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "input_batches")
public class InputBatchEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(nullable = false)
    public String gtin;

    @Column(name = "lot_number", nullable = false)
    public String lotNumber;

    @Column(name = "product_id", nullable = false)
    public UUID productId;

    @Column(name = "initial_quantity", nullable = false, precision = 10, scale = 2)
    public BigDecimal initialQuantity;

    @Column(name = "remaining_quantity", nullable = false, precision = 10, scale = 2)
    public BigDecimal remainingQuantity;

    @Column(name = "expiration_date", nullable = false)
    public Instant expirationDate;

    @Column(nullable = false)
    public String unit;

    @Column(name = "created_at", nullable = false, insertable = false, updatable = false)
    public Instant createdAt;
}
