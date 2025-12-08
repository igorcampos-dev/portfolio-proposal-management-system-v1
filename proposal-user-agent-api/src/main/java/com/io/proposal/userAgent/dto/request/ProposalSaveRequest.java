package com.io.proposal.userAgent.dto.request;

import com.io.proposal.userAgent.dto.fields.ClientType;
import com.io.proposal.userAgent.dto.fields.PaymentModel;
import com.io.proposal.userAgent.dto.fields.RiskCategory;
import com.io.proposal.userAgent.generator.ContractRandomGenerator;
import lombok.Builder;

import java.math.BigDecimal;

@Builder
public record ProposalSaveRequest(
        String contractId,
        String clientName,
        ClientType clientType,
        String serviceType,
        BigDecimal contractValue,
        int durationMonths,
        PaymentModel paymentModel,
        RiskCategory riskCategory,
        boolean requiresOnSite,
        int slaHours
) {

    public static ProposalSaveRequest generateRandomProposal(){
        return ProposalSaveRequest.builder()
                .contractId(ContractRandomGenerator.generateContractId())
                .clientName(ContractRandomGenerator.generateClientName())
                .clientType(ContractRandomGenerator.generateClientType())
                .serviceType(ContractRandomGenerator.generateServiceType())
                .contractValue(ContractRandomGenerator.generateContractValue())
                .durationMonths(ContractRandomGenerator.generateDurationMonths())
                .paymentModel(ContractRandomGenerator.generatePaymentModel())
                .riskCategory(ContractRandomGenerator.generateRiskCategory())
                .requiresOnSite(ContractRandomGenerator.generateRequiresOnSite())
                .slaHours(ContractRandomGenerator.generateSlaHours())
                .build();
    }

}