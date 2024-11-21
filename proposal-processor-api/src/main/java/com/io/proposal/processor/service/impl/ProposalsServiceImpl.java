package com.io.proposal.processor.service.impl;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;
import com.io.proposal.processor.mapper.ProposalMapper;
import com.io.proposal.processor.queue.producer.ProposalUpdateProducer;
import com.io.proposal.processor.rule.processor.ProposalRuleProcessor;
import com.io.proposal.processor.service.ProposalsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsServiceImpl implements ProposalsService {

    private final ProposalUpdateProducer managementProducer;
    private final ProposalRuleProcessor ruleProcessor;
    private final ProposalMapper mapper;

    @Override
    public void process(ProposalInternal proposalInternal) {
        log.info("Iniciando o processo de aplicação das regras na proposta...");
        ProposalUpdateInternal update = ruleProcessor.process(proposalInternal);
        log.info("Regras validadas, tudo ok.");
        managementProducer.publishMessage(update);
    }

    private void publishProposalToUpdateToQueue(ProposalUpdateInternal proposal) {
        this.managementProducer.publishMessage(proposal);
    }

}