package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.fields.Status;

public class ApprovedRule implements ProposalRule {

    @Override
    public ProposalUpdateBo apply(ProposalDto dto) {
        return ProposalUpdateBo.build(dto.id(), Status.APPROVED, "Contract meets all requirements");
    }
}
