package com.io.proposal.management.domain.dto.response;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.io.proposal.management.domain.entity.fields.ClientType;
import com.io.proposal.management.domain.entity.fields.PaymentModel;
import com.io.proposal.management.domain.entity.fields.RiskCategory;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Response model for retrieving a proposal by its ID")
public record ProposalGetByIdResponse(

        @Schema(description = "Unique identifier of the proposal", example = "PROP-2025-00017")
        String id,

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
        int slaHours,

        @Schema(description = "Current status of the proposal", example = "APPROVED")
        String status,

        @Schema(description = "Date and time when the proposal was created", example = "2025-01-14T10:32:00")
        LocalDateTime createdAt,

        @Schema(description = "Date and time when the proposal was last updated", example = "2025-01-18T14:10:00")
        LocalDateTime updatedAt,

        @Schema(description = "Risk assessment description", example = "Analysis pending")
        String analysisDescription
) {}

