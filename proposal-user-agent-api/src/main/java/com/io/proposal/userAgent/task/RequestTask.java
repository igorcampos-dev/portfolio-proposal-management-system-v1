package com.io.proposal.userAgent.task;

import com.github.benmanes.caffeine.cache.Cache;
import com.io.proposal.userAgent.client.KeycloakAuthClient;
import com.io.proposal.userAgent.client.ProposalClient;
import com.io.proposal.userAgent.dto.request.ProposalSaveRequest;
import com.io.proposal.userAgent.dto.response.KeycloakTokenResponse;
import com.io.proposal.userAgent.properties.KeycloakProperties;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@Component
@RequiredArgsConstructor
public class RequestTask {

    private final Cache<@NonNull String, KeycloakTokenResponse> cache;
    private final KeycloakAuthClient authClient;
    private final ProposalClient proposalClient;
    private final KeycloakProperties properties;

    public void execute() {
        try {
            Thread.sleep(ThreadLocalRandom.current().nextInt(50, 500));

            var token = this.getToken(properties.getForm()).access_token();
            var proposal = ProposalSaveRequest.generateRandomProposal();

            proposalClient.saveProposal(proposal, "Bearer ".concat(token));

            log.debug("Sent proposal OK");

        } catch (Exception e) {
            log.warn("Request failed", e);
        }
    }

    public KeycloakTokenResponse getToken(String form) {
        return cache.get(form, key -> {
            log.info("send request to keycloak.");
            return authClient.getToken(key);
        });
    }

}
