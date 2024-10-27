package com.io.proposal.processor.queue.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.RequiredArgsConstructor;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.QueueBuilder;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class RabbitMQConfig {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Value("${spring.rabbitmq.template.queue}")
    private String queue;

    @Bean
    public Queue queue (){
        return QueueBuilder.durable(queue)
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