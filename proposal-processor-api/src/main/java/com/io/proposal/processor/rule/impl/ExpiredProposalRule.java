package com.io.proposal.processor.rule.impl;

import com.io.proposal.processor.domain.bo.ProposalBo;
import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.rule.ProposalRule;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@SuppressWarnings("unused")
public class ExpiredProposalRule implements ProposalRule {

    @Override
    public boolean applies(ProposalBo proposal) {
        return ChronoUnit.DAYS.between(proposal.getUpdatedAt(), LocalDateTime.now()) >= 30;
    }

    @Override
    public ProposalUpdateBo process(ProposalBo proposal) {
        return ProposalUpdateBo.setProposalExpired(proposal.getId());
    }

}