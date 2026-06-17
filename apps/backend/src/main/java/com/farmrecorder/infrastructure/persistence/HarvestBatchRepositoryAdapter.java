package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.HarvestBatch;
import com.farmrecorder.domain.model.HarvestBatchStatus;
import com.farmrecorder.domain.port.HarvestBatchRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.HarvestBatchMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class HarvestBatchRepositoryAdapter implements HarvestBatchRepositoryPort, PanacheRepository<HarvestBatchEntity> {

    private final HarvestBatchMapper mapper;

    @Inject
    public HarvestBatchRepositoryAdapter(HarvestBatchMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public HarvestBatch save(HarvestBatch batch) {
        HarvestBatchEntity entity = mapper.toEntity(batch);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<HarvestBatch> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<HarvestBatch> findAvailableByProductId(UUID productId) {
        return find("productId = ?1 and status = ?2", productId, HarvestBatchStatus.AVAILABLE)
                .list()
                .stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public boolean decrementRemainingQuantity(UUID batchId, int quantityToDeduct) {
        long updated = update("remainingQuantity = remainingQuantity - ?1, status = CASE WHEN remainingQuantity - ?1 <= 0 THEN 'DEPLETED' ELSE 'AVAILABLE' END WHERE id = ?2 and remainingQuantity >= ?1",
                quantityToDeduct, batchId);
        return updated > 0;
    }
}
