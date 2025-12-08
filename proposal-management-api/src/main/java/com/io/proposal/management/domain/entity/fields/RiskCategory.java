package com.io.proposal.management.domain.entity.fields;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Risk category of the contract")
public enum RiskCategory {
    LOW,
    MEDIUM,
    HIGH,
    CRITICAL
}
