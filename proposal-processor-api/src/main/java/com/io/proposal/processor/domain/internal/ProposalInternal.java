package com.io.proposal.processor.domain.internal;

import com.io.proposal.processor.domain.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposalInternal {
    private String id;
    private String description;
    private BigDecimal value;
    private String supplierId;
    private String supplierName;
    private String clientId;
    private String clientName;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String analysisDescription;
}
