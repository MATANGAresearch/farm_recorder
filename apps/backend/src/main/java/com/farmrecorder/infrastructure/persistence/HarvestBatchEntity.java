package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.domain.model.HarvestBatchStatus;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "harvest_batches")
public class HarvestBatchEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(name = "product_id", nullable = false)
    public UUID productId;

    @Column(name = "location_id", nullable = false)
    public UUID locationId;

    @Column(name = "harvested_by_id", nullable = false)
    public String harvestedById;

    @Column(name = "harvested_at", nullable = false)
    public Instant harvestedAt;

    @Column(name = "batch_number", nullable = false, unique = true)
    public String batchNumber;

    @Column(name = "initial_quantity", nullable = false)
    public int initialQuantity;

    @Column(name = "remaining_quantity", nullable = false)
    public int remainingQuantity;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public HarvestBatchStatus status;
}
