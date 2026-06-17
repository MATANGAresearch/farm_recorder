package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.InputBatch;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface InputBatchRepositoryPort {
    InputBatch save(InputBatch batch);
    Optional<InputBatch> findById(UUID id);
    Optional<InputBatch> findByGtinAndLotNumber(String gtin, String lotNumber);
    List<InputBatch> getAll();
    boolean decrementRemainingQuantity(String gtin, String lotNumber, BigDecimal quantityToDeduct);
}
