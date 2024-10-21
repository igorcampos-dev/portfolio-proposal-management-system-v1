package com.io.proposal.management.service;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;

public interface ProposalsService {
    ProposalSaveResponse saveProposal(ProposalSaveRequest dto);
    ProposalUpdateResponse updateProposal(ProposalUpdateRequest dto);
    ProposalDeleteResponse deleteProposal(String id);
    ProposalGetListResponse getProposal(int page, String id);
}
