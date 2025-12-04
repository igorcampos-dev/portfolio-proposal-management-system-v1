package com.io.proposal.userAgent.proposalProcessorApi.generator;

import com.github.javafaker.Faker;
import com.io.proposal.userAgent.proposalProcessorApi.dto.request.ProposalSaveRequest;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.concurrent.ThreadLocalRandom;

@Component
public class RealisticProposalGenerator {

    private final Faker faker = new Faker();
    private final ThreadLocalRandom random = ThreadLocalRandom.current();

    public ProposalSaveRequest generate() {

        double value = switch (random.nextInt(3)) {
            case 0 -> random.nextDouble(50.0, 2_000.0);
            case 1 -> random.nextDouble(2_000.0, 50_000.0);
            default -> random.nextDouble(50_000.0, 500_000.0);
        };

        LocalDateTime createdAt = LocalDateTime.now()
                                               .minusDays(random.nextInt(0, 30))
                                               .minusHours(random.nextInt(0, 24))
                                               .minusMinutes(random.nextInt(0, 60));

        return new ProposalSaveRequest(
                faker.commerce().productName() + " - " + faker.commerce().material(),
                BigDecimal.valueOf(value).setScale(2, BigDecimal.ROUND_HALF_UP),
                generateSupplierId(),
                faker.company().name(),
                generateClientId(),
                faker.name().fullName(),
                createdAt
        );
    }

    private String generateSupplierId() {
        return "SUP-" + random.nextInt(1000, 9999);
    }

    private String generateClientId() {
        return "CLI-" + random.nextInt(1000, 9999);
    }
}
