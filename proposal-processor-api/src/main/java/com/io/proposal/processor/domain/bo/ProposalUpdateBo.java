package com.io.proposal.processor.domain.bo;

import com.io.proposal.processor.domain.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProposalUpdateBo {
    private String id;
    private Status status;
    private String analysisDescription;

    public static ProposalUpdateBo setProposalExpired(String id) {
        return ProposalUpdateBo.builder()
                .id(id)
                .status(Status.EXPIRED)
                .analysisDescription("Proposta está expirada, excedeu o limite de 30 dias.")
                .build();
    }

    public static ProposalUpdateBo setProposalRequireManualApproval(String id) {
        return ProposalUpdateBo.builder()
                .id(id)
                .status(Status.REQUIRES_MANUAL_APPROVAL)
                .analysisDescription("Proposa necessita aprovação manual, valor alto.")
                .build();
    }

    public static ProposalUpdateBo setProposalLowValue(String id) {
        return ProposalUpdateBo.builder()
                .id(id)
                .status(Status.DENIED)
                .analysisDescription("Proposa Possui um valor muito baixo, o minimo é 1.000 reais.")
                .build();
    }

    public static ProposalUpdateBo setProposalProcessed(String id) {
        return ProposalUpdateBo.builder()
                .id(id)
                .status(Status.PROCESSED)
                .analysisDescription("Proposa Autorizada, atende todos os requisitos.")
                .build();
    }

}
