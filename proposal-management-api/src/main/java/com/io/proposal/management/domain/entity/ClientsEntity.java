package com.io.proposal.management.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(schema = "public", name = "clients")
public class ClientsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "clientId", unique = true)
    private String clientId;

    @Column(name = "document", nullable = false, unique = true)
    private String document;

    @Column(name = "name", nullable = false, unique = true)
    private String name;

}
