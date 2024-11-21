package com.io.proposal.processor.service;

import com.io.proposal.processor.domain.internal.ProposalInternal;

public interface ProposalsService {
    void process(ProposalInternal proposal);
}
