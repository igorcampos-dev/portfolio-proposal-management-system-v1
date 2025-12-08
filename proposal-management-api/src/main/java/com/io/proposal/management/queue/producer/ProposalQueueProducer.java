package com.io.proposal.management.queue.producer;

import com.io.proposal.management.domain.entity.ProposalEntity;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class ProposalQueueProducer {

    
    @Value("${spring.rabbitmq.template.queues.producers.proposal-queue}")
    private String queue;

    private final RabbitTemplate rabbitTemplate;

    public void publishMessage(ProposalEntity entity){
        log.info("Starting message publishing process for id: {}", entity.getId());
        this.rabbitTemplate.convertAndSend(
                "",
                queue,
                entity
        );
        log.info("Message with id: {} published.", entity.getId());
    }

}
