package com.io.proposal.processor.domain.internal;

import com.io.proposal.processor.domain.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProposalInternal {

    private String proposalId;
    private String clientName;
    private String clientDocument;
    private BigDecimal amount;
    private String purpose;
    private LocalDateTime creationDate;
    private Status status;

}
