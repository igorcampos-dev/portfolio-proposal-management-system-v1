package com.io.proposal.management.queue.producer;

import com.io.proposal.management.domain.entity.ProposalEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProposalQueueProducer {

    @SuppressWarnings("unused")
    @Value("${spring.rabbitmq.template.queues.producers.proposal-queue}")
    private String queue;

    private final RabbitTemplate rabbitTemplate;

    public void publishMessage(ProposalEntity entity){
        this.rabbitTemplate.convertAndSend(
                "",
                queue,
                entity
        );
    }

}
