package com.io.proposal.processor.queue.consumer;

import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.service.ProposalsService;
import com.rabbitmq.client.Channel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class ProposalsConsumer {

    private final ObjectMapper mapper;
    private final ProposalsService proposalsService;

    @RabbitListener(queues = "${spring.rabbitmq.template.queues.consumers.proposal-management}")
    public void listenEmailQueue(@Payload ProposalDto dto, Channel channel, Message message) throws IOException {
        try {
            log.info("Proposal received: {}", dto);
            this.proposalsService.process(dto);
        } catch (Exception e){
            log.error("Error to consume message | error: {}", e.getMessage());
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, false);
        }
    }

}
