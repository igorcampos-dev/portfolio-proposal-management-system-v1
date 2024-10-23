package com.io.proposal.processor.domain.dto.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Status {
    PENDING("PENDING");

    private final String status;
}
