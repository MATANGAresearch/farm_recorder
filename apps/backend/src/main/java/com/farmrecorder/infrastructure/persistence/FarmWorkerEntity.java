package com.farmrecorder.infrastructure.persistence;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "farm_workers")
@IdClass(FarmWorkerEntity.FarmWorkerId.class)
public class FarmWorkerEntity extends PanacheEntityBase {

    @Id
    @Column(name = "farm_id", nullable = false)
    public UUID farmId;

    @Id
    @Column(name = "worker_email", nullable = false)
    public String workerEmail;

    @Column(name = "role", nullable = false)
    public String role;

    public FarmWorkerEntity() {}

    public FarmWorkerEntity(UUID farmId, String workerEmail) {
        this.farmId = farmId;
        this.workerEmail = workerEmail;
        this.role = "WORKER";
    }

    public FarmWorkerEntity(UUID farmId, String workerEmail, String role) {
        this.farmId = farmId;
        this.workerEmail = workerEmail;
        this.role = role;
    }

    public static class FarmWorkerId implements Serializable {
        public UUID farmId;
        public String workerEmail;

        public FarmWorkerId() {}

        public FarmWorkerId(UUID farmId, String workerEmail) {
            this.farmId = farmId;
            this.workerEmail = workerEmail;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            FarmWorkerId that = (FarmWorkerId) o;
            return Objects.equals(farmId, that.farmId) && Objects.equals(workerEmail, that.workerEmail);
        }

        @Override
        public int hashCode() {
            return Objects.hash(farmId, workerEmail);
        }
    }
}
