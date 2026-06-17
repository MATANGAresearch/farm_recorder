package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.domain.model.MediaType;
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
@Table(name = "media")
public class MediaEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(name = "activity_log_id", nullable = false)
    public UUID activityLogId;

    @Column(name = "media_url", nullable = false)
    public String mediaUrl;

    @Enumerated(EnumType.STRING)
    @Column(name = "media_type", nullable = false)
    public MediaType mediaType;

    @Column(name = "captured_gps_lat")
    public Double capturedGpsLat;

    @Column(name = "captured_gps_lng")
    public Double capturedGpsLng;

    @Column(nullable = false)
    public Instant timestamp;
}
