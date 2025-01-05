package com.io.proposal.management.domain.entity;

import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.entity.fields.Status;
import com.io.proposal.management.domain.internal.ProposalUpdateInternal;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "proposal")
public class ProposalEntity {

    @Id
    @Column(name = "id", nullable = false, length = 36, unique = true)
    @GeneratedValue(strategy = GenerationType.UUID)
    private String id;

    @Column(name = "description", nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(name = "value", nullable = false, precision = 15, scale = 2)
    private BigDecimal value;

    @Column(name = "supplier_id", nullable = false, length = 50)
    private String supplierId;

    @Column(name = "supplier_name", nullable = false)
    private String supplierName;

    @Column(name = "client_id", nullable = false, length = 50)
    private String clientId;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Column(name = "status", nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private Status status;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "analysis_description", nullable = false, columnDefinition = "TEXT")
    private String analysisDescription;

    public void updateProposal(ProposalUpdateRequest dto) {
        this.description = dto.description();
        this.value = dto.value();
        this.supplierId = dto.supplierId();
        this.supplierName = dto.supplierName();
        this.clientId = dto.clientId();
        this.clientName = dto.clientName();
    }

    public void updateStatusProposal(ProposalUpdateInternal proposalUpdate) {
        this.analysisDescription = proposalUpdate.getAnalysisDescription();
        this.status = proposalUpdate.getStatus();
    }
}
