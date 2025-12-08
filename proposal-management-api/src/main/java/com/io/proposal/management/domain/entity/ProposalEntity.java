package com.io.proposal.management.domain.entity;

import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.entity.fields.ClientType;
import com.io.proposal.management.domain.entity.fields.PaymentModel;
import com.io.proposal.management.domain.entity.fields.RiskCategory;
import com.io.proposal.management.domain.entity.fields.Status;
import com.io.proposal.management.domain.internal.ProposalUpdateInternal;
import jakarta.persistence.*;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "service_contract")
public class ProposalEntity {

    @Id
    @Column(name = "id", nullable = false, length = 36, unique = true)
    private String id;

    @Column(name = "contract_id", nullable = false, length = 50)
    private String contractId;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_type", nullable = false, length = 10)
    private ClientType clientType;

    @Column(name = "service_type", nullable = false)
    private String serviceType;

    @Column(name = "contract_value", nullable = false, precision = 15, scale = 2)
    private BigDecimal contractValue;

    @Column(name = "duration_months", nullable = false)
    private Integer durationMonths;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_model", nullable = false, length = 20)
    private PaymentModel paymentModel;

    @Enumerated(EnumType.STRING)
    @Column(name = "risk_category", nullable = false, length = 20)
    private RiskCategory riskCategory;

    @Column(name = "requires_on_site", nullable = false)
    private boolean requiresOnSite;

    @Column(name = "sla_hours", nullable = false)
    private Integer slaHours;

    @Column(name = "status", nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private Status status;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "analysis_description", nullable = false, columnDefinition = "TEXT")
    private String analysisDescription;

    public void updateProposal(@Valid ProposalUpdateRequest dto) {
        this.contractId = dto.contractId();
        this.clientName = dto.clientName();
        this.clientType = dto.clientType();
        this.serviceType= dto.serviceType();
        this.contractValue = dto.contractValue();
        this.durationMonths = dto.durationMonths();
        this.paymentModel = dto.paymentModel();
        this.riskCategory = dto.riskCategory();
        this.requiresOnSite = dto.requiresOnSite();
        this.slaHours = dto.slaHours();
    }

    public void updateStatusProposal(ProposalUpdateInternal proposalUpdate) {
        this.analysisDescription = proposalUpdate.getAnalysisDescription();
        this.status = proposalUpdate.getStatus();
    }

}
