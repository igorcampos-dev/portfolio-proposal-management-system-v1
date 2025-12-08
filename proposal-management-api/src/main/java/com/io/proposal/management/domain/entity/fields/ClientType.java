package com.io.proposal.management.domain.entity.fields;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Client type: PF for individuals, PJ for companies")
public enum ClientType {
    PF,
    PJ
}
