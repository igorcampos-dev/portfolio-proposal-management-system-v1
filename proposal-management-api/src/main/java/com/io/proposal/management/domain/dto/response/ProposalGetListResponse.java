package com.io.proposal.management.domain.dto.response;

import com.io.proposal.management.domain.dto.response.fields.ProposalGetResponse;
import lombok.Builder;
import java.util.List;

@Builder
public record ProposalGetListResponse(
        List<ProposalGetResponse> responseList
) {}
