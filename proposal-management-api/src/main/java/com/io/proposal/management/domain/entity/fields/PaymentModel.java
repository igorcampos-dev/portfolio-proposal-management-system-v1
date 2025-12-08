package com.io.proposal.management.domain.entity.fields;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Payment model type")
public enum PaymentModel {
    MONTHLY,
    ONE_TIME,
    QUARTERLY,
    YEARLY
}
