package com.io.proposal.processor.mapper;

import com.io.proposal.processor.domain.dto.ProposalCompleteDto;
import com.io.proposal.processor.domain.internal.ProposalCompleteInternal;

public interface ProposalMapper {
    ProposalCompleteInternal toInternal(ProposalCompleteDto dto);
}
