package com.io.proposal.processor.mapper;

import com.io.proposal.processor.domain.dto.ProposalCompleteDto;
import com.io.proposal.processor.domain.internal.ProposalCompleteInternal;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public abstract class ProposalMapper {

    @Mapping(target = ".", source = ".")
    public abstract ProposalCompleteInternal toInternal(ProposalCompleteDto dto);
}
