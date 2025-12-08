package com.io.proposal.processor.domain.dto;

import com.io.proposal.processor.domain.fields.ClientType;
import com.io.proposal.processor.domain.fields.PaymentModel;
import com.io.proposal.processor.domain.fields.RiskCategory;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProposalDto(
        String id,
        String contractId,
        String clientName,
        ClientType clientType,
        String serviceType,
        BigDecimal contractValue,
        int durationMonths,
        PaymentModel paymentModel,
        RiskCategory riskCategory,
        boolean requiresOnSite,
        int slaHours,
        String status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String analysisDescription
) {}
