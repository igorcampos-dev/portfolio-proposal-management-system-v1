package com.io.proposal.processor.queue.properties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@NoArgsConstructor
@AllArgsConstructor
@ConfigurationProperties("spring.rabbitmq.template.queues")
public class QueueProperties {
    private ConsumersProperties consumers;
    private ProducersProperties producers;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ConsumersProperties {
        private String proposalManagement;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ProducersProperties {
        private String proposalManagement;
    }

}
