package com.io.proposal.management.config.properties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@NoArgsConstructor
@AllArgsConstructor
@ConfigurationProperties("spring.security.oauth2.resourceserver.jwt")
public class KeycloakProperties {

    private String issuerUri;
    private String jwkUri;

    public String getIssuerUriLocal() {
        return this.replaceWord(issuerUri);
    }

    private String replaceWord(String input) {
        return input.replaceAll("//([^:]+):", "//" + "localhost" + ":");
    }

    public boolean isValidIssuerUri(String issuer) {
        return issuer.equals(this.getIssuerUri()) || issuer.equals(this.getIssuerUriLocal());
    }


}
