package com.farmrecorder.infrastructure.persistence;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.util.UUID;

@Entity
@Table(name = "locations")
public class LocationEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(unique = true, nullable = false)
    public String gln;

    @Column(nullable = false)
    public String name;

    @Column(nullable = false)
    public String type;

    @Column(name = "geo_json_polygon", columnDefinition = "TEXT")
    public String geoJsonPolygon;
}
