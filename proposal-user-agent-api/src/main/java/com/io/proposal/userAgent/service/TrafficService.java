package com.io.proposal.userAgent.service;

import com.io.proposal.userAgent.generator.PoissonGenerator;
import com.io.proposal.userAgent.task.RequestTask;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.IntStream;

@Slf4j
@Component
@RequiredArgsConstructor
public class TrafficService {

    private static final int AVERAGE_PER_SECOND = 16;
    private final RequestTask requestTask;
    private final ExecutorService executor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

    @PostConstruct
    public void init() {
        requestTask.execute();
    }

    public void generateTrafficTick() {
        int qty = PoissonGenerator.next(AVERAGE_PER_SECOND);
        log.info("Traffic tick -> {} requests", qty);
        for (int i = 0; i < qty; i++) {
            executor.submit(requestTask::execute);
        }
    }

}

