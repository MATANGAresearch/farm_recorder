package com.farmrecorder.infrastructure.persistence;

import com.farmrecorder.core.util.IdGenerator;
import com.farmrecorder.domain.model.InputBatch;
import com.farmrecorder.domain.port.InputBatchRepositoryPort;
import com.farmrecorder.infrastructure.rest.mapper.InputBatchMapper;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class InputBatchRepositoryAdapter implements InputBatchRepositoryPort, PanacheRepository<InputBatchEntity> {

    private final InputBatchMapper mapper;

    @Inject
    public InputBatchRepositoryAdapter(InputBatchMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    @Transactional
    public InputBatch save(InputBatch batch) {
        InputBatchEntity entity = mapper.toEntity(batch);
        if (entity.id == null) {
            entity.id = IdGenerator.generate();
        }
        persist(entity);
        return mapper.toDomain(entity);
    }

    @Override
    public Optional<InputBatch> findById(UUID id) {
        return find("id", id).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public Optional<InputBatch> findByGtinAndLotNumber(String gtin, String lotNumber) {
        return find("gtin = ?1 and lotNumber = ?2", gtin, lotNumber).firstResultOptional().map(mapper::toDomain);
    }

    @Override
    public List<InputBatch> getAll() {
        return listAll().stream().map(mapper::toDomain).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public boolean decrementRemainingQuantity(String gtin, String lotNumber, BigDecimal quantityToDeduct) {
        long updated = update("remainingQuantity = CASE WHEN remainingQuantity - ?1 < 0 THEN 0.00 ELSE remainingQuantity - ?1 END WHERE gtin = ?2 and lotNumber = ?3",
                quantityToDeduct, gtin, lotNumber);
        return updated > 0;
    }
}
