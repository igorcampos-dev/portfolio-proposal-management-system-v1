package com.io.proposal.userAgent.proposalProcessorApi.dto.request;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProposalSaveRequest(
        String description,
        BigDecimal value,
        String supplierId,
        String supplierName,
        String clientId,
        String clientName,
        LocalDateTime createdAt
) {}