package com.io.proposal.processor.domain.internal;

import com.io.proposal.processor.domain.fields.LoyaltyLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ClientsInternal {

    private String clientId;
    private String document;
    private String name;
    private LoyaltyLevel level;

}
