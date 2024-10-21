package com.io.proposal.management.domain.entity.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    PENDING("PENDING");

    private final String status;
}
