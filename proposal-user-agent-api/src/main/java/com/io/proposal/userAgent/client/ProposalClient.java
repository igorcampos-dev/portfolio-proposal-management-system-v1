package com.io.proposal.userAgent.client;

import com.io.proposal.userAgent.dto.request.ProposalSaveRequest;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(
    name = "proposalClient",
    url = "${external.proposal-management-api}"
)
public interface ProposalClient {

    @PostMapping("/v1/proposals")
    void saveProposal(@RequestBody ProposalSaveRequest request,
                      @RequestHeader("Authorization") String authorization);

}
