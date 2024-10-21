package com.io.proposal.management.domain.dto.response.fields;

import lombok.Builder;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Builder
public record ProposalGetResponse(
        String proposalId,
        String clientName,
        String clientDocument,
        BigDecimal amount,
        String purpose,
        LocalDateTime creationDate,
        String status
) {}
