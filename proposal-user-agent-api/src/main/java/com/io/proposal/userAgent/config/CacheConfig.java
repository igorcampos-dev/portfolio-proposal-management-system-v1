package com.io.proposal.userAgent.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.io.proposal.userAgent.dto.response.KeycloakTokenResponse;
import lombok.NonNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.Duration;

@Configuration
public class CacheConfig {

    @Bean
    public Cache<@NonNull String, KeycloakTokenResponse> keycloakTokenCache() {
        return Caffeine.newBuilder()
                .expireAfterWrite(Duration.ofMinutes(4))
                .initialCapacity(200)
                .maximumSize(500)
                .build();
    }

}
