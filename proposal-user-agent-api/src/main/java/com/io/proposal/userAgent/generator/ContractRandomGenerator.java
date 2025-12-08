package com.io.proposal.userAgent.generator;

import com.io.proposal.userAgent.dto.fields.ClientType;
import com.io.proposal.userAgent.dto.fields.PaymentModel;
import com.io.proposal.userAgent.dto.fields.RiskCategory;
import net.datafaker.providers.base.BaseFaker;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Year;
import java.util.concurrent.ThreadLocalRandom;

@Component
public class ContractRandomGenerator {

    private static final BaseFaker faker = new BaseFaker();

    public static String generateContractId() {
        int year = Year.now().getValue();
        int seq = faker.number().numberBetween(10000, 99999);
        return "CTR-" + year + "-" + seq;
    }

    public static String generateClientName() {
        return faker.company().name();
    }

    public static ClientType generateClientType() {
        ClientType[] values = ClientType.values();
        return values[faker.random().nextInt(values.length)];
    }

    public static String generateServiceType() {
        return faker.job().field();
    }

    public static BigDecimal generateContractValue() {
        long min = 20_000;
        long max = 500_000;
        long value = ThreadLocalRandom.current().nextLong(min, max);
        return BigDecimal.valueOf(value).setScale(2, RoundingMode.HALF_UP);
    }

    public static int generateDurationMonths() {
        return faker.number().numberBetween(6, 60);
    }

    public static PaymentModel generatePaymentModel() {
        PaymentModel[] values = PaymentModel.values();
        return values[faker.random().nextInt(values.length)];
    }

    public static RiskCategory generateRiskCategory() {
        RiskCategory[] values = RiskCategory.values();
        return values[faker.random().nextInt(values.length)];
    }

    public static boolean generateRequiresOnSite() {
        return faker.bool().bool();
    }

    public static int generateSlaHours() {
        return faker.number().numberBetween(12, 120);
    }

}
