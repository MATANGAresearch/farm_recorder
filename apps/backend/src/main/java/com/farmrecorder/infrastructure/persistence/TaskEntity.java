package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.domain.model.TaskStatus;
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
@Table(name = "tasks")
public class TaskEntity extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(name = "farm_id", nullable = false)
    public UUID farmId;

    @Column(name = "assigned_to", nullable = false)
    public String assignedTo;

    @Column(nullable = false)
    public String title;

    @Column(columnDefinition = "TEXT")
    public String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    public TaskStatus status;

    @Column(name = "due_date")
    public Instant dueDate;
}
