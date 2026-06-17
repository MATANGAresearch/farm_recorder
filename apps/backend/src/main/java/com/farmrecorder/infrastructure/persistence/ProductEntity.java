package com.farmrecorder.infrastructure.persistence;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "products")
public class ProductEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(unique = true, nullable = false)
    public String gtin;

    @Column(nullable = false)
    public String name;

    @Column(name = "batch_prefix")
    public String batchPrefix;

    public String variety;

    @Column(name = "default_unit_price", precision = 10, scale = 2)
    public BigDecimal defaultUnitPrice;

    @Column(nullable = false)
    public String type;

    @Column(name = "epa_registration_number")
    public String epaRegistrationNumber;

    @Column(name = "active_ingredients", length = 1024)
    public String activeIngredients;

    @Column(name = "rei_hours")
    public Integer reiHours;

    @Column(name = "phi_days")
    public Integer phiDays;

    @Column(name = "is_local_only", nullable = false)
    public Boolean isLocalOnly;

    @Column(name = "admin_notes", columnDefinition = "TEXT")
    public String adminNotes;
}
