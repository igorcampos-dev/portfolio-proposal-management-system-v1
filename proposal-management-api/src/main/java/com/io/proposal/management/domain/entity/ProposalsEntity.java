package com.io.proposal.management.domain.entity;

import com.io.proposal.management.domain.entity.fields.Status;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "proposals")
public class ProposalsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "proposal_id", unique = true)
    private String proposalId;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Column(name = "client_document", nullable = false)
    private String clientDocument;

    @Column(name = "amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "purpose", nullable = false)
    private String purpose;

    @Column(name = "creation_date", nullable = false)
    private LocalDateTime creationDate;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private Status status;

    public ProposalsEntity(ClientsEntity clientsEntity, String purpose, BigDecimal amount) {
        this.proposalId = UUID.randomUUID().toString();
        this.clientName = clientsEntity.getName();
        this.clientDocument = clientsEntity.getDocument();
        this.amount = amount;
        this.purpose = purpose;
        this.creationDate = LocalDateTime.now();
        this.status = Status.PENDING;
    }

}
