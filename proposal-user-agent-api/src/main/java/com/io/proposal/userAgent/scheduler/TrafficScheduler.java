package com.io.proposal.userAgent.scheduler;

import com.io.proposal.userAgent.service.TrafficService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class TrafficScheduler {

    private final TrafficService service;

    @Scheduled(fixedRate = 1000)
    public void tick() {
        service.generateTrafficTick();
    }

}
