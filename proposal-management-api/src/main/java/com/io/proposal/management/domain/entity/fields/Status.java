package com.io.proposal.management.domain.entity.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    PENDING("PENDING"),
    APPROVED("APPROVED"),
    REJECTED("REJECTED"),
    EXPIRED("EXPIRED"),
    REQUIRES_MANUAL_APPROVAL("REQUIRES_MANUAL_APPROVAL"),
    ERROR("ERROR");

    private final String status;
}
