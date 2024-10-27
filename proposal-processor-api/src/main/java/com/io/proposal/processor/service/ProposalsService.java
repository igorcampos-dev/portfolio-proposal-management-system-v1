package com.io.proposal.processor.service;

import com.io.proposal.processor.domain.internal.ProposalCompleteInternal;

public interface ProposalsService {
    void process(ProposalCompleteInternal proposal);
}
