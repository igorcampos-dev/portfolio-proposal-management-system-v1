package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.fields.RiskCategory;
import com.io.proposal.processor.domain.fields.Status;
import java.math.BigDecimal;

public class ManualApprovalRule implements ProposalRule {

    @Override
    public ProposalUpdateBo apply(ProposalDto dto) {
        if (BigDecimal.valueOf(500_000).compareTo(dto.contractValue()) < 0) {
            return ProposalUpdateBo.build(dto.id(), Status.REQUIRES_MANUAL_APPROVAL, "High-value contract, requires manual approval");
        }
        if (dto.slaHours() < 12 && dto.riskCategory() == RiskCategory.MEDIUM) {
            return ProposalUpdateBo.build(dto.id(), Status.REQUIRES_MANUAL_APPROVAL, "Risk and SLA for this contract require manual approval");
        }
        return null;
    }


}
