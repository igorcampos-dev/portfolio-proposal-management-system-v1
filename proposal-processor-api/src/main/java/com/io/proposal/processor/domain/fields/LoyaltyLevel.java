package com.io.proposal.processor.domain.fields;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum LoyaltyLevel {

    BRONZE("BRONZE"),
    SILVER("SILVER"),
    GOLD("GOLD"),
    PLATINUM("PLATINUM"),
    DIAMOND("DIAMOND");

    private final String status;

}
