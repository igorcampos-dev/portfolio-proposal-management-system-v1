package com.io.proposal.management.repository;

import com.io.proposal.management.domain.entity.ProposalsEntity;
import com.io.proposal.management.domain.entity.fields.Status;
import com.io.proposal.management.exception.ProposalPendingException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProposalsRepository extends JpaRepository<ProposalsEntity, String> {

    default ProposalsEntity findByIdOrElseThrow(String id){
        return this.findById(id).orElseThrow( () -> new NullPointerException("Proposta não encontrada com esse id "));
    }

    default void ifStatusPendingThenThrow(String id){
        var entity = this.findByIdOrElseThrow(id);
        if (entity.getStatus() == Status.PENDING){
            throw new ProposalPendingException("Proposta está pendente.");
        }
    }

    default void ifProposalNotExistsThenThrow(String id){
        if (!this.existsById(id)){
            throw new NullPointerException("Proposta não encontrada com esse id");
        }
    }

    default Page<ProposalsEntity> findByPaginatedIdOrElseThrow(int page, String id){
        Pageable pageable = PageRequest.of(page,6);

        Page<ProposalsEntity> proposalsEntities = this.findAll(pageable);
        if (proposalsEntities.isEmpty()){
            throw new NullPointerException("Não existe propostas no salvas.");
        }

        return proposalsEntities;
    }

}
