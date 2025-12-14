package com.io.proposal.management.domain.bo;

import com.io.proposal.management.domain.entity.fields.ClientType;
import com.io.proposal.management.domain.entity.fields.PaymentModel;
import com.io.proposal.management.domain.entity.fields.RiskCategory;
import com.io.proposal.management.domain.entity.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposalBo {
    private String id;
    private String contractId;
    private String clientName;
    private ClientType clientType;
    private String serviceType;
    private BigDecimal contractValue;
    private Integer durationMonths;
    private PaymentModel paymentModel;
    private RiskCategory riskCategory;
    private boolean requiresOnSite;
    private Integer slaHours;
    private Status status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String analysisDescription;
}
