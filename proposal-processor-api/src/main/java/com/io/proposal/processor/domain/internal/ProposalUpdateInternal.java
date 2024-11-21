package com.io.proposal.processor.domain.internal;

import com.io.proposal.processor.domain.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProposalUpdateInternal {
    private String id;
    private Status status;
    private String analysisDescription;

    public static ProposalUpdateInternal setProposalExpired(String id) {
        return ProposalUpdateInternal.builder()
                .id(id)
                .status(Status.EXPIRED)
                .analysisDescription("Proposta está expirada, excedeu o limite de 30 dias.")
                .build();
    }

    public static ProposalUpdateInternal setProposalRequireManualApproval(String id) {
        return ProposalUpdateInternal.builder()
                .id(id)
                .status(Status.REQUIRES_MANUAL_APPROVAL)
                .analysisDescription("Proposa necessita aprovação manual, valor alto.")
                .build();
    }

    public static ProposalUpdateInternal setProposalLowValue(String id) {
        return ProposalUpdateInternal.builder()
                .id(id)
                .status(Status.DENIED)
                .analysisDescription("Proposa Possui um valor muito baixo, o minimo é 1.000 reais.")
                .build();
    }

    public static ProposalUpdateInternal setProposalProcessed(String id) {
        return ProposalUpdateInternal.builder()
                .id(id)
                .status(Status.PROCESSED)
                .analysisDescription("Proposa Autorizada, atende todos os requisitos.")
                .build();
    }

}
