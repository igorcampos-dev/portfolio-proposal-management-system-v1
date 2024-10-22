package com.io.proposal.management.service.impl;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.entity.ClientsEntity;
import com.io.proposal.management.domain.entity.ProposalsEntity;
import com.io.proposal.management.mapper.ProposalsMapper;
import com.io.proposal.management.queue.producer.ProposalQueueProducer;
import com.io.proposal.management.repository.ClientsRepository;
import com.io.proposal.management.repository.ProposalsRepository;
import com.io.proposal.management.service.ProposalsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsServiceImpl implements ProposalsService {

    private final ClientsRepository clientsRepository;
    private final ProposalsRepository proposalsRepository;
    private final ProposalQueueProducer producer;

    @Override
    public ProposalSaveResponse saveProposal(ProposalSaveRequest dto) {
        ClientsEntity clientsEntity = clientsRepository.findByIdOrElseThrow(dto.userId());
        ProposalsEntity proposalEntity = new ProposalsEntity(clientsEntity, dto.purpose(), dto.amount());
        var response = this.proposalsRepository.save(proposalEntity);
        producer.publishMessage(response);
        return ProposalsMapper.entityToSaveResponse(response);
    }

    @Override
    public ProposalUpdateResponse updateProposal(ProposalUpdateRequest dto) {
        ClientsEntity clientsEntity = clientsRepository.findByIdOrElseThrow(dto.userId());
        this.proposalsRepository.ifProposalNotExistsThenThrow(dto.proposalId());
        this.proposalsRepository.ifStatusNotPendingThenThrow(dto.proposalId());
        ProposalsEntity proposalEntity = new ProposalsEntity(clientsEntity, dto.purpose(), dto.amount());
        var response = this.proposalsRepository.save(proposalEntity);
        return ProposalsMapper.entityToUpdateResponse(response);
    }

    @Override
    public ProposalDeleteResponse deleteProposal(String id) {
        var response = this.proposalsRepository.findByIdOrElseThrow(id);
        this.proposalsRepository.deleteById(id);
        return ProposalsMapper.entityToDeleteResponse(response);
    }

    @Override
    public ProposalGetListResponse getProposal(int page, String id) {
        ClientsEntity entity = this.clientsRepository.findByIdOrElseThrow(id);
        var response = this.proposalsRepository.findByPaginatedNameOrElseThrow(page, entity.getName());
        return ProposalsMapper.entitieListToGetResponse(response);
    }

}
