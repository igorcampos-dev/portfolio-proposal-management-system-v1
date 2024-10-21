package com.io.proposal.management.mapper;

import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.fields.ProposalGetResponse;
import com.io.proposal.management.domain.entity.ProposalsEntity;
import org.springframework.data.domain.Page;
import java.util.ArrayList;
import java.util.List;

public class ProposalsMapper {

    public static ProposalSaveResponse entityToSaveResponse(ProposalsEntity entity){
        return ProposalSaveResponse.builder()
                .message("Proposta salva com sucesso")
                .proposalId(entity.getProposalId())
                .clientName(entity.getClientName())
                .clientDocument(entity.getClientDocument())
                .amount(entity.getAmount())
                .purpose(entity.getPurpose())
                .creationDate(entity.getCreationDate())
                .status(entity.getStatus().toString())
                .build();
    }

    public static ProposalUpdateResponse entityToUpdateResponse(ProposalsEntity entity){
        return ProposalUpdateResponse.builder()
                .message("Proposta atualizada com sucesso")
                .proposalId(entity.getProposalId())
                .clientName(entity.getClientName())
                .clientDocument(entity.getClientDocument())
                .amount(entity.getAmount())
                .purpose(entity.getPurpose())
                .creationDate(entity.getCreationDate())
                .status(entity.getStatus().toString())
                .build();
    }


    public static ProposalDeleteResponse entityToDeleteResponse(ProposalsEntity entity) {
        return ProposalDeleteResponse.builder()
                .message("Proposta deletada com sucesso")
                .proposalId(entity.getProposalId())
                .clientName(entity.getClientName())
                .clientDocument(entity.getClientDocument())
                .amount(entity.getAmount())
                .purpose(entity.getPurpose())
                .creationDate(entity.getCreationDate())
                .status(entity.getStatus().toString())
                .build();
    }

    public static ProposalGetListResponse entitieListToGetResponse(Page<ProposalsEntity> response) {
        List<ProposalGetResponse> responseList = new ArrayList<>();

        response.forEach( entity -> {

            ProposalGetResponse proposalGetResponse = ProposalGetResponse.builder()
                    .proposalId(entity.getProposalId())
                    .clientName(entity.getClientName())
                    .clientDocument(entity.getClientDocument())
                    .amount(entity.getAmount())
                    .purpose(entity.getPurpose())
                    .creationDate(entity.getCreationDate())
                    .status(entity.getStatus().toString())
                    .build();

            responseList.add(proposalGetResponse);

        });

        return new ProposalGetListResponse(responseList);

    }
}
