package com.io.proposal.processor.domain.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    PENDING("PENDING");

    private final String status;
}
