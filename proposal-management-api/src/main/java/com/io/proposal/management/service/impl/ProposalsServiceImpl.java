package com.io.proposal.management.service.impl;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalGetByIdResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.domain.entity.ProposalEntity;
import com.io.proposal.management.domain.internal.ProposalUpdateInternal;
import com.io.proposal.management.domain.mapper.ProposalsMapper;
import com.io.proposal.management.queue.producer.ProposalQueueProducer;
import com.io.proposal.management.repository.ProposalRepository;
import com.io.proposal.management.service.ProposalsService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProposalsServiceImpl implements ProposalsService {

    private final ProposalRepository proposalRepository;
    private final ProposalQueueProducer producer;
    private final ProposalsMapper mapper;

    @Override
    @Transactional
    public ProposalSaveResponse saveProposal(@Valid ProposalSaveRequest dto) {
        log.info("Preparing to save to the database...");
        var entity = mapper.toEntity(dto);
        this.proposalRepository.save(entity);
        log.info("Saved to the database.");
        this.producer.publishMessage(entity);
        return mapper.toResponseSave(entity);
    }

    @Override
    @Transactional
    public ProposalUpdateResponse updateProposal(@Valid ProposalUpdateRequest dto) {
        log.info("Preparing to update in the database...");
        ProposalEntity entity = this.proposalRepository.findByIdOrElseThrow(dto.id());
        this.ensureNotOlderThan30Minutes(entity.getUpdatedAt());
        entity.updateProposal(dto);
        this.proposalRepository.save(entity);
        log.info("Updated in the database.");
        return mapper.toResponseUpdate(entity);
    }

    @Override
    public void updateStatusProposal(ProposalUpdateInternal proposalUpdate) {
        log.info("Preparing to update status in the database...");
        ProposalEntity entity = this.proposalRepository.findByIdOrElseThrow(proposalUpdate.getId());
        entity.updateStatusProposal(proposalUpdate);
        log.info("Status updated in the database.");
        this.proposalRepository.save(entity);
    }

    @Override
    public ProposalGetByIdResponse findById(String id) {
        log.info("Preparing to retrieve the proposal from the database...");
        ProposalEntity entity = this.proposalRepository.findByIdOrElseThrow(id);
        log.info("Proposal retrieved successfully.");
        return mapper.toResponseGetById(entity);
    }

    private void ensureNotOlderThan30Minutes(LocalDateTime dateTime) {
        if (LocalDateTime.now().isAfter(dateTime)) {
            throw new IllegalArgumentException("Proposal update time is limited to 30 minutes. Time expired.");
        }
    }

}
