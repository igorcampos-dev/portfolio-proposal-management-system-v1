package com.io.proposal.userAgent.proposalProcessorApi.service;

import com.io.proposal.userAgent.proposalProcessorApi.client.KeycloakAuthClient;
import com.io.proposal.userAgent.proposalProcessorApi.client.ProposalClient;
import com.io.proposal.userAgent.proposalProcessorApi.dto.response.KeycloakTokenResponse;
import com.io.proposal.userAgent.proposalProcessorApi.generator.RealisticProposalGenerator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@Service
@RequiredArgsConstructor
public class TrafficSimulatorService {

    private final ProposalClient proposalClient;
    private final KeycloakAuthClient authClient;
    private final RealisticProposalGenerator generator;

    @Value("${keycloak.client-id}")
    private String clientId;

    @Value("${keycloak.client-secret}")
    private String clientSecret;

    @Value("${keycloak.username}")
    private String username;

    @Value("${keycloak.password}")
    private String password;

    @Scheduled(fixedRate = 1000)
    public void simulateTraffic() {

        String form = "grant_type=password"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&username=" + username
                + "&password=" + password;

        KeycloakTokenResponse response = authClient.getToken(form);

        int requests = ThreadLocalRandom.current().nextInt(1, 6);
        log.info("Starting simulation cycle. Requests to send: {}", requests);

        for (int i = 0; i < requests; i++) {
            sendRandomRequest("Bearer ".concat(response.access_token()));
            sleepRandom();
        }
    }

    private void sendRandomRequest(String token) {
        var proposal = generator.generate();
        log.debug("Generated proposal: {}", proposal);

        try {
            proposalClient.saveProposal(proposal, token);
            log.info("Proposal sent successfully");
        } catch (Exception e) {
            log.error("Error sending proposal", e);
        }
    }

    private void sleepRandom() {
        try {
            long delay = ThreadLocalRandom.current().nextLong(200, 2000);
            log.trace("Sleeping for {} ms before next request", delay);
            Thread.sleep(delay);
        } catch (InterruptedException ignored) {
            Thread.currentThread().interrupt();
        }
    }

}

