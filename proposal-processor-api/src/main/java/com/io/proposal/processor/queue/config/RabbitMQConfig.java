package com.io.proposal.processor.queue.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.io.proposal.processor.queue.properties.QueueProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.QueueBuilder;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor

public class RabbitMQConfig {

    private final QueueProperties properties;
    private static final ObjectMapper mapper = new ObjectMapper();

    @Bean
    public Queue queue (){
        return QueueBuilder.durable(properties.getConsumers().getProposalManagement())
                           .withArgument("x-dead-letter-exchange", "dead_letter_exchange")
                           .withArgument("x-dead-letter-routing-key", "dead_letter_key")
                           .build();
    }

    @Bean
    public Jackson2JsonMessageConverter messageConverter(){
        mapper.registerModule(new JavaTimeModule());
        return new Jackson2JsonMessageConverter(mapper);
    }

}