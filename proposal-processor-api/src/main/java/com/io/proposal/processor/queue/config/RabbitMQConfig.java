package com.io.proposal.processor.queue.config;

import com.io.proposal.processor.queue.properties.QueueProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.QueueBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class RabbitMQConfig {

    private final QueueProperties properties;

    @Bean
    public Queue queue (){
        return QueueBuilder.durable(properties.getConsumers().getProposalManagement())
                           .withArgument("x-dead-letter-exchange", "dead_letter_exchange")
                           .withArgument("x-dead-letter-routing-key", "dead_letter_key")
                           .build();
    }


}