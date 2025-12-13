package com.io.proposal.processor.service;

import com.io.proposal.processor.domain.bo.ProposalBo;

public interface ProposalsService {
    void process(ProposalBo proposal);
}
