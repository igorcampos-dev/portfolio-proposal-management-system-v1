package com.io.proposal.processor.mapper;

import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.internal.ProposalInternal;
import jakarta.validation.Valid;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public abstract class ProposalMapper {

    @Mapping(target = ".", source = ".")
    public abstract ProposalInternal toInternal(@Valid ProposalDto dto);

}
