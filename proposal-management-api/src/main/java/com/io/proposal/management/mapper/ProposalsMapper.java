package com.io.proposal.management.mapper;

import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.entity.ProposalsEntity;
import org.springframework.data.domain.Page;

public interface ProposalsMapper {
    ProposalSaveResponse entityToSaveResponse(ProposalsEntity entity);
    ProposalUpdateResponse entityToUpdateResponse(ProposalsEntity entity);
    ProposalDeleteResponse entityToDeleteResponse(ProposalsEntity entity);
    ProposalGetListResponse entitiesListToGetResponse(Page<ProposalsEntity> response);
}
