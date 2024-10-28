package com.io.proposal.processor.mapper.imp;

import com.io.proposal.processor.domain.dto.ProposalCompleteDto;
import com.io.proposal.processor.domain.internal.ProposalCompleteInternal;
import com.io.proposal.processor.mapper.ProposalMapper;
import org.springframework.stereotype.Component;

@Component
@SuppressWarnings("unused")
public class ProposalMapperImpl implements ProposalMapper {

    @Override
    public ProposalCompleteInternal toInternal(ProposalCompleteDto dto) {
        return null;
    }

}
