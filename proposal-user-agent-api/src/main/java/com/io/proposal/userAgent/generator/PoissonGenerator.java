package com.io.proposal.userAgent.generator;

import java.util.concurrent.ThreadLocalRandom;

public final class PoissonGenerator {

    public static int next(double mean) {
        double L = Math.exp(-mean);
        double p = 1.0;
        int k = 0;
        do {
            k++;
            p *= ThreadLocalRandom.current().nextDouble();
        } while (p > L);
        return k - 1;
    }
}
