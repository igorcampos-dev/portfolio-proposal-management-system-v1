package com.io.proposal.management.domain.dto.request;

import com.io.proposal.management.domain.entity.fields.ClientType;
import com.io.proposal.management.domain.entity.fields.PaymentModel;
import com.io.proposal.management.domain.entity.fields.RiskCategory;
import io.swagger.v3.oas.annotations.media.Schema;

import java.math.BigDecimal;

@Schema(description = "Represents a service contract between a client and the company")
public record ProposalSaveRequest(

        @Schema(description = "Unique identifier of the contract", example = "CTR-2025-00421")
        String contractId,

        @Schema(description = "Client name", example = "AlphaTech Solutions")
        String clientName,

        @Schema(description = "Type of client (PF or PJ)")
        ClientType clientType,

        @Schema(description = "Type of service contracted", example = "Software Development")
        String serviceType,

        @Schema(description = "Total value of the contract", example = "150000")
        BigDecimal contractValue,

        @Schema(description = "Duration of the contract in months", example = "12")
        int durationMonths,

        @Schema(description = "Payment model")
        PaymentModel paymentModel,

        @Schema(description = "Risk category")
        RiskCategory riskCategory,

        @Schema(description = "Whether the service requires on-site presence", example = "false")
        boolean requiresOnSite,

        @Schema(description = "Service Level Agreement time in hours", example = "48")
        int slaHours
) {}

