package com.io.proposal.processor.domain.internal;

import com.io.proposal.processor.domain.dto.ClientsDto;
import com.io.proposal.processor.domain.dto.ProposalDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProposalCompleteInternal {

    private ClientsDto clientsDto;
    private ProposalDto proposalDto;

}
