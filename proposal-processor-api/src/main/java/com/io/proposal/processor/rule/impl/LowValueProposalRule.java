package com.io.proposal.processor.rule.impl;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;
import com.io.proposal.processor.rule.ProposalRule;

import java.math.BigDecimal;

public class LowValueProposalRule implements ProposalRule {

    @Override
    public boolean applies(ProposalInternal proposal) {
        return proposal.getValue().compareTo(new BigDecimal("1000")) < 0;
    }

    @Override
    public ProposalUpdateInternal process(ProposalInternal proposal) {
        return ProposalUpdateInternal.setProposalLowValue(proposal.getId());
    }

}