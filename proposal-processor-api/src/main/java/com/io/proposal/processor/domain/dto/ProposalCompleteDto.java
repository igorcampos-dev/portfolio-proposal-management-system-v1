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

    @JsonProperty("clientsEntityProducer")
    private ClientsDto clientsDto;

    @JsonProperty("proposalsEntityProducer")
    private ProposalDto proposalDto;
}
