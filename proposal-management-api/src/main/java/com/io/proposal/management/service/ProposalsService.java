package com.io.proposal.management.service;

import com.io.proposal.management.domain.bo.ProposalUpdateBo;
import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalGetByIdResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;

public interface ProposalsService {
    ProposalSaveResponse saveProposal(ProposalSaveRequest dto);
    ProposalUpdateResponse updateProposal(ProposalUpdateRequest dto);
    void updateStatusProposal(ProposalUpdateBo proposalUpdate);
    ProposalGetByIdResponse findById(String id);
}
