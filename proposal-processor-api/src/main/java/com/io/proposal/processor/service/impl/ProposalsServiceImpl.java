package com.io.proposal.processor.service.impl;

import com.io.proposal.processor.queue.producer.ProposalManagementProducer;
import com.io.proposal.processor.queue.producer.ProposalReportProducer;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ProposalsServiceImpl {

    private final ProposalManagementProducer managementProducer;
    private final ProposalReportProducer reportProducer;

}
