package com.io.proposal.management.domain.entity.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    PENDING("PENDING"),
    PROCESSING("PROCESSING"),
    PROCESSED("PROCESSED"),
    DENIED("DENIED"),
    EXPIRED("EXPIRED"),
    REQUIRES_MANUAL_APPROVAL("REQUIRES_MANUAL_APPROVAL");

    private final String status;
}
