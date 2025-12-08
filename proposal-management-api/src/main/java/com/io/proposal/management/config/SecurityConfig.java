package com.io.proposal.management.config;

import com.io.proposal.management.config.properties.KeycloakProperties;
import com.io.proposal.management.exception.global.CustomAuthenticationEntryPoint;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.context.annotation.Bean;
import org.springframework.core.convert.converter.Converter;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;
import java.util.Map;

@Component

@RequiredArgsConstructor
public class SecurityConfig {

    private final KeycloakProperties properties;

    interface AuthoritiesConverter extends Converter<Map<String, Object>, Collection<GrantedAuthority>> {}

    @Bean
    AuthoritiesConverter realmRolesAuthoritiesConverter() {
        return claims -> {

            @SuppressWarnings("unchecked")
            Map<String, Object> resourceAccess = (Map<String, Object>) claims.getOrDefault("resource_access", Map.of());

            @SuppressWarnings("unchecked")
            Map<String, Object> clientAccess = (Map<String, Object>) resourceAccess.getOrDefault("proposal-management-client-private", Map.of());

            @SuppressWarnings("unchecked")
            List<String> roles = (List<String>) clientAccess.getOrDefault("roles", List.of());

            return roles.stream()
                    .map(role -> new SimpleGrantedAuthority("ROLE_" + role.toUpperCase()))
                    .map(GrantedAuthority.class::cast)
                    .toList();
        };
    }


    @Bean
    JwtAuthenticationConverter authenticationConverter(
            Converter<Map<String, Object>,
            Collection<GrantedAuthority>> authoritiesConverter
    ) {
        var authenticationConverter = new JwtAuthenticationConverter();
        authenticationConverter.setJwtGrantedAuthoritiesConverter(jwt -> authoritiesConverter.convert(jwt.getClaims()));
        return authenticationConverter;
    }

    @Bean
    public JwtDecoder jwtDecoder() {
        NimbusJwtDecoder jwtDecoder = NimbusJwtDecoder.withJwkSetUri(properties.getJwkUri()).build();

        jwtDecoder.setJwtValidator(jwt -> {
            String issuer = jwt.getIssuer().toString();
            if (!properties.isValidIssuerUri(issuer)) {
                return OAuth2TokenValidatorResult.failure(
                        new OAuth2Error("invalid_token", "Invalid issuer: " + issuer, null)
                );
            }
            return OAuth2TokenValidatorResult.success();
        });

        return jwtDecoder;
    }

    @Bean
    @SneakyThrows(Exception.class)
    SecurityFilterChain resourceServerSecurityFilterChain(
            HttpSecurity http,
            Converter<Jwt, AbstractAuthenticationToken> authenticationConverter,
            CustomAuthenticationEntryPoint authenticationEntryPoint
    ) {

        http.csrf(AbstractHttpConfigurer::disable);
        http.oauth2ResourceServer(resourceServer ->
                resourceServer.jwt(jwtDecoder ->
                                jwtDecoder.jwtAuthenticationConverter(authenticationConverter))
                                          .authenticationEntryPoint(authenticationEntryPoint)
        );
        http.sessionManagement(sessions -> sessions.sessionCreationPolicy(SessionCreationPolicy.STATELESS)).csrf(AbstractHttpConfigurer::disable);
        http.authorizeHttpRequests(requests -> {
            requests.requestMatchers(HttpMethod.POST, "/v1/proposals").hasRole("BASIC");
            requests.requestMatchers(HttpMethod.PUT, "/v1/proposals").hasRole("BASIC");
            requests.requestMatchers(HttpMethod.GET, "/v1/proposals").hasRole("BASIC");
            requests.requestMatchers(HttpMethod.GET, "/swagger-ui/**", "/v3/api-docs*/**", "/swagger-ui.html").permitAll();
            requests.anyRequest().authenticated();
        });
        http.httpBasic(Customizer.withDefaults());
        return http.build();
    }

}
