package com.io.proposal.processor.queue.consumer;

import com.io.proposal.processor.domain.bo.ProposalQueueBo;
import com.io.proposal.processor.mapper.ProposalMapper;
import com.io.proposal.processor.service.ProposalsService;
import com.rabbitmq.client.Channel;
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
    public void listenEmailQueue(@Payload ProposalQueueBo proposalQueueBo, Channel channel, Message message) throws IOException {
        try {
            log.info("Proposal recebida: {}", proposalQueueBo);
            this.proposalsService.process(mapper.toInternal(proposalQueueBo));
        } catch (Exception e){
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, false);
        }
    }

}
