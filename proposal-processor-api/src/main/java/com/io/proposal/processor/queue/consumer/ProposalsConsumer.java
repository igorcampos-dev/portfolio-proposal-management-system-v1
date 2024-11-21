package com.io.proposal.processor.queue.consumer;

import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.mapper.ProposalMapper;
import com.io.proposal.processor.service.ProposalsService;
import com.rabbitmq.client.Channel;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsConsumer {

    private final ProposalsService proposalsService;
    private final ProposalMapper mapper;

    @RabbitListener(queues = "${spring.rabbitmq.template.queues.consumers.proposal-management}")
    public void listenEmailQueue(@Valid @Payload ProposalDto dto, Channel channel, Message message) throws IOException {
        try {
            log.info("Proposal recebida: {}", dto);
            this.proposalsService.process(mapper.toInternal(dto));
        } catch (Exception e){
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, false);
        }
    }

}
