package com.io.proposal.management.service.impl;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
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
@SuppressWarnings("unused")
public class ProposalsServiceImpl implements ProposalsService {

    private final ProposalRepository proposalRepository;
    private final ProposalQueueProducer producer;
    private final ProposalsMapper mapper;

    @Override
    @Transactional
    public ProposalSaveResponse saveProposal(@Valid ProposalSaveRequest dto) {
        log.info("Preparando pra salvar no banco...");
        var entity = mapper.toEntity(dto);
        this.proposalRepository.save(entity);
        log.info("Salvo no banco.");
        this.producer.publishMessage(entity);
        return mapper.toResponseSave(entity);
    }

    @Override
    @Transactional
    public ProposalUpdateResponse updateProposal(@Valid ProposalUpdateRequest dto) {
        log.info("Preparando pra atualizar no banco...");
        ProposalEntity entity = this.proposalRepository.findByIdOrElseThrow(dto.id());
        this.ensureNotOlderThan30Minutes(entity.getUpdatedAt());
        entity.updateProposal(dto);
        this.proposalRepository.save(entity);
        log.info("Atualizado no banco.");
        return mapper.toResponseUpdate(entity);
    }

    @Override
    public void updateStatusProposal(ProposalUpdateInternal proposalUpdate) {
        log.info("Preparando pra atualizar o status no banco...");
        ProposalEntity entity = this.proposalRepository.findByIdOrElseThrow(proposalUpdate.getId());
        entity.updateStatusProposal(proposalUpdate);
        log.info("Atualizado o status no banco.");
        this.proposalRepository.save(entity);
    }

    private void ensureNotOlderThan30Minutes(LocalDateTime dateTime) {
        if (LocalDateTime.now().isAfter(dateTime)) {
            throw new IllegalArgumentException("O tempo de atualização de uma proposta é de 30 minutos, tempo expirado.");
        }
    }

}
