package com.io.proposal.processor.domain.bo;

import com.io.proposal.processor.domain.fields.Status;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProposalQueueBo(
        String id,
        String description,
        BigDecimal value,
        String supplierId,
        String supplierName,
        String clientId,
        String clientName,
        Status status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String analysisDescription
) {}
