package com.io.proposal.processor.rule.impl;

import com.io.proposal.processor.domain.bo.ProposalBo;
import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.rule.ProposalRule;

import java.math.BigDecimal;

@SuppressWarnings("unused")
public class ManualApprovalRule implements ProposalRule {

    @Override
    public boolean applies(ProposalBo proposal) {
        return proposal.getValue().compareTo(new BigDecimal("50000")) > 0;
    }

    @Override
    public ProposalUpdateBo process(ProposalBo proposal) {
        return ProposalUpdateBo.setProposalRequireManualApproval(proposal.getId());
    }

}