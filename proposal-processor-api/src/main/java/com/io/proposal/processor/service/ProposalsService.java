package com.io.proposal.processor.service;

import com.io.proposal.processor.domain.dto.ProposalDto;

public interface ProposalsService {
    void process(ProposalDto dto);
}
