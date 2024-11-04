package com.io.proposal.processor.service.impl;

import com.io.proposal.processor.domain.internal.ProposalCompleteInternal;
import com.io.proposal.processor.queue.producer.ProposalManagementProducer;
import com.io.proposal.processor.queue.producer.ProposalReportProducer;
import com.io.proposal.processor.service.ProposalsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsServiceImpl implements ProposalsService {

    private final ProposalManagementProducer managementProducer;
    private final ProposalReportProducer reportProducer;

    @Override
    public void process(ProposalCompleteInternal proposal) {
        log.info("Service received: {}", proposal);
    }

}
