package com.io.proposal.management.scheduler;

import com.io.proposal.management.domain.entity.ProposalEntity;
import com.io.proposal.management.domain.entity.fields.Status;
import com.io.proposal.management.queue.producer.ProposalQueueProducer;
import com.io.proposal.management.repository.ProposalRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;

@Slf4j
@Component
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class ProposalsScheduler {

    private final ProposalRepository repository;
    private final ProposalQueueProducer producer;

    @Scheduled(fixedRate = 1800000)
    public void processPendingProposals() {
        this.repository.findPendingProposals(Status.PENDING, LocalDateTime.now())
                       .forEach(this::execute);
    }

    @Transactional
    private void execute(ProposalEntity entity){
        try {
            log.info("Iniciando o processamento de uma proposta: {}", entity.getId());
            this.alterProposalStatus(Status.PROCESSING, entity);
            this.producer.publishMessage(entity);
        } catch (Exception e){
            log.error("Houve um erro ao processar a proposta: {}, causa: {}", entity.getId(), e.getMessage());
            this.alterProposalStatus(Status.ERROR, entity);
        }
    }

    private void alterProposalStatus(Status status, ProposalEntity entity){
        entity.setStatus(status);
        this.repository.save(entity);
    }

}
