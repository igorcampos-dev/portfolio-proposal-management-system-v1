package com.io.proposal.management.domain.mapper;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.entity.ProposalEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public abstract class ProposalsMapper {

    @Mapping(target = ".", source = ".")
    @Mapping(target = "status", constant = "PENDING")
    @Mapping(target = "analysisDescription", constant = "Pendente a análise.")
    @Mapping(target = "updatedAt", expression = "java(dto.createdAt().plusMinutes(30))")
    public abstract ProposalEntity toEntity(ProposalSaveRequest dto);

    @Mapping(target = ".", source = ".")
    public abstract ProposalSaveResponse toResponseSave(ProposalEntity entity);

    @Mapping(target = ".", source = ".")
    public abstract ProposalUpdateResponse toResponseUpdate(ProposalEntity entity);

}
