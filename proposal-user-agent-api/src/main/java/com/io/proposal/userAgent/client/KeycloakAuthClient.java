package com.io.proposal.userAgent.client;

import com.io.proposal.userAgent.dto.response.KeycloakTokenResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(
        name = "keycloakAuthClient",
        url = "${external.auth-keycloak-api}"
)
public interface KeycloakAuthClient {

    @PostMapping(
            value = "/realms/proposal-management/protocol/openid-connect/token",
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE
    )
    KeycloakTokenResponse getToken(@RequestBody String formData);

}
