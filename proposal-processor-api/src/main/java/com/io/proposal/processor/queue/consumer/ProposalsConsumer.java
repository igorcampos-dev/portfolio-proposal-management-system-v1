package com.io.proposal.processor.queue.consumer;

import com.io.proposal.processor.domain.dto.ProposalDto;
import com.rabbitmq.client.Channel;
import jakarta.validation.Valid;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;
import java.io.IOException;

@Component
public class ProposalsConsumer {

    @RabbitListener(queues = "${spring.rabbitmq.template.queue}")
    public void listenEmailQueue(@Valid @Payload ProposalDto dto, Channel channel, Message message) throws IOException {
        try {
            System.out.println(String.format("Proposal received: %s", dto));
        } catch (Exception e){
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, false);
        }
    }

}
