package com.io.proposal.management.domain.dto.response;

import lombok.Builder;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Builder
public record ProposalSaveResponse(
        String id,
        String description,
        BigDecimal value,
        String supplierId,
        String supplierName,
        String clientId,
        String clientName,
        String status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
