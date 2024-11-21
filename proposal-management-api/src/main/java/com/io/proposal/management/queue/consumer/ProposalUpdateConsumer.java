package com.io.proposal.management.queue.consumer;

import com.io.proposal.management.domain.internal.ProposalUpdateInternal;
import com.io.proposal.management.service.ProposalsService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalUpdateConsumer {

    private final ProposalsService service;

    @RabbitListener(queues = "${spring.rabbitmq.template.queues.consumers.proposal-update}")
    public void listenToProposalQueue(@Valid @Payload ProposalUpdateInternal proposalUpdate){
        this.service.updateStatusProposal(proposalUpdate);
    }

}
