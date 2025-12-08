package com.io.proposal.management.domain.mapper;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.response.*;
import com.io.proposal.management.domain.entity.ProposalEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public abstract class ProposalsMapper {

    @Mapping(target = ".", source = ".")
    @Mapping(target = "id", expression = "java(java.util.UUID.randomUUID().toString())")
    @Mapping(target = "status", constant = "PENDING")
    @Mapping(target = "analysisDescription", constant = "Pendente a análise.")
    @Mapping(target = "createdAt", expression = "java(java.time.LocalDateTime.now())")
    @Mapping(target = "updatedAt", expression = "java(java.time.LocalDateTime.now().plusMinutes(30))")
    public abstract ProposalEntity toEntity(ProposalSaveRequest dto);

    @Mapping(target = ".", source = ".")
    public abstract ProposalSaveResponse toResponseSave(ProposalEntity entity);

    @Mapping(target = ".", source = ".")
    public abstract ProposalUpdateResponse toResponseUpdate(ProposalEntity entity);

    @Mapping(target = ".", source = ".")
    public abstract ProposalGetByIdResponse toResponseGetById(ProposalEntity entity);

}
