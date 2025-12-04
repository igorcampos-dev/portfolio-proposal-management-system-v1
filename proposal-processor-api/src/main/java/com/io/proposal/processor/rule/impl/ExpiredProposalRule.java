package com.io.proposal.processor.rule.impl;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;
import com.io.proposal.processor.rule.ProposalRule;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@SuppressWarnings("unused")
public class ExpiredProposalRule implements ProposalRule {

    @Override
    public boolean applies(ProposalInternal proposal) {
        return ChronoUnit.DAYS.between(proposal.getUpdatedAt(), LocalDateTime.now()) >= 30;
    }

    @Override
    public ProposalUpdateInternal process(ProposalInternal proposal) {
        return ProposalUpdateInternal.setProposalExpired(proposal.getId());
    }

}