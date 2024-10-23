package com.io.proposal.processor.queue.consumer;

import com.io.proposal.processor.domain.dto.ProposalDto;
import jakarta.validation.Valid;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;

@Component
public class ProposalsConsumer {

    @RabbitListener(queues = "${spring.rabbitmq.template.queue}")
    public void listenEmailQueue(@Valid @Payload ProposalDto dto){
        System.out.println(String.format("Proposal received: %s", dto));
    }

}
