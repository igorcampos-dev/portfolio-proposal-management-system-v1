package com.io.proposal.processor.mapper;

import com.io.proposal.processor.domain.bo.ProposalBo;
import com.io.proposal.processor.domain.bo.ProposalQueueBo;
import jakarta.validation.Valid;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public abstract class ProposalMapper {

    @Mapping(target = ".", source = ".")
    public abstract ProposalBo toInternal(@Valid ProposalQueueBo dto);

}
