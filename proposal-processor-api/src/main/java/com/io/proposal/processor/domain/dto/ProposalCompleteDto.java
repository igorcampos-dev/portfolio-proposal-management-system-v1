package com.io.proposal.processor.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProposalCompleteDto {

    @JsonProperty(namespace = "clientsEntity")
    private ClientsDto clientsDto;

    @JsonProperty(namespace = "proposalsEntity")
    private ProposalDto proposalDto;
}
