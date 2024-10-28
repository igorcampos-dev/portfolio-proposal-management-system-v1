package com.io.proposal.management.domain.internal;

import com.io.proposal.management.domain.entity.ClientsEntity;
import com.io.proposal.management.domain.entity.ProposalsEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProposalCompleteInternal {

    private ClientsEntity clientsEntityProducer;
    private ProposalsEntity proposalsEntityProducer;

}
