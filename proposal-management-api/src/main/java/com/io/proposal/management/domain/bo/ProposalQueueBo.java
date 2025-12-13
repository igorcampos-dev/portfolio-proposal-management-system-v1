package com.io.proposal.management.domain.bo;

import com.io.proposal.management.domain.entity.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposalQueueBo {
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
