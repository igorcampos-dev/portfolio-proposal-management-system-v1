package com.io.proposal.processor.rule.impl;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;
import com.io.proposal.processor.rule.ProposalRule;

import java.math.BigDecimal;

@SuppressWarnings("unused")
public class ManualApprovalRule implements ProposalRule {

    @Override
    public boolean applies(ProposalInternal proposal) {
        return proposal.getValue().compareTo(new BigDecimal("50000")) > 0;
    }

    @Override
    public ProposalUpdateInternal process(ProposalInternal proposal) {
        return ProposalUpdateInternal.setProposalRequireManualApproval(proposal.getId());
    }

}