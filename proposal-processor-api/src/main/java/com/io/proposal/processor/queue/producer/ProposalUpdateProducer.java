package com.io.proposal.processor.queue.producer;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.queue.properties.QueueProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProposalUpdateProducer {

    private final RabbitTemplate rabbitTemplate;
    private final QueueProperties properties;

    public void publishMessage(ProposalUpdateBo proposalUpdate){
        rabbitTemplate.convertAndSend(
                "",
                properties.getProducers().getProposalManagement(),
                proposalUpdate
        );
    }

}
