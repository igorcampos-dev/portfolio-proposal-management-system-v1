package com.io.proposal.management.domain.dto.response;

import lombok.Builder;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Builder
public record ProposalUpdateResponse(
        String message,
        String proposalId,
        String clientName,
        String clientDocument,
        BigDecimal amount,
        String purpose,
        LocalDateTime creationDate,
        String status
) {}
