package com.io.proposal.management.service.impl;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.entity.ClientsEntity;
import com.io.proposal.management.domain.entity.ProposalsEntity;
import com.io.proposal.management.domain.internal.ProposalCompleteInternal;
import com.io.proposal.management.mapper.ProposalsMapper;
import com.io.proposal.management.queue.producer.ProposalQueueProducer;
import com.io.proposal.management.repository.ClientsRepository;
import com.io.proposal.management.repository.ProposalsRepository;
import com.io.proposal.management.service.ProposalsService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsServiceImpl implements ProposalsService {

    private final ClientsRepository clientsRepository;
    private final ProposalsRepository proposalsRepository;
    private final ProposalQueueProducer producer;
    private final ProposalsMapper mapper;

    @Override
    @Transactional
    public ProposalSaveResponse saveProposal(@Valid ProposalSaveRequest dto) {
        ClientsEntity clientEntity = clientsRepository.findByIdOrElseThrow(dto.userId());

        ProposalsEntity proposalEntity = new ProposalsEntity(clientEntity, dto.purpose(), dto.amount());

        this.proposalsRepository
                .ifPurposeExistsByClientNameThenThrow(proposalEntity.getClientName(), proposalEntity.getPurpose());

        proposalsRepository.save(proposalEntity);
        producer.publishMessage(new ProposalCompleteInternal(clientEntity, proposalEntity));
        return mapper.entityToSaveResponse(proposalEntity);
    }

    @Override
    @Transactional
    public ProposalUpdateResponse updateProposal(@Valid ProposalUpdateRequest dto) {
        ClientsEntity clientsEntity = clientsRepository.findByIdOrElseThrow(dto.userId());

        ensureProposalExists(dto.proposalId());
        ensureProposalStatusIsPending(dto.proposalId());

        ProposalsEntity proposalEntity = new ProposalsEntity(clientsEntity, dto.purpose(), dto.amount());
        proposalsRepository.save(proposalEntity);
        return mapper.entityToUpdateResponse(proposalEntity);
    }

    @Override
    public ProposalDeleteResponse deleteProposal(String id) {
        ProposalsEntity responseEntity = proposalsRepository.findByIdOrElseThrow(id);
        proposalsRepository.deleteById(id);
        return mapper.entityToDeleteResponse(responseEntity);
    }

    @Override
    public ProposalGetListResponse getProposal(int page, String id) {
        ClientsEntity clientsEntity = clientsRepository.findByIdOrElseThrow(id);
        var proposalsList = proposalsRepository.findByPaginatedNameOrElseThrow(page, clientsEntity.getName());
        return mapper.entitiesListToGetResponse(proposalsList);
    }

    private void ensureProposalExists(String proposalId) {
        proposalsRepository.ifProposalNotExistsThenThrow(proposalId);
    }

    private void ensureProposalStatusIsPending(String proposalId) {
        proposalsRepository.ifStatusNotPendingThenThrow(proposalId);
    }

}
