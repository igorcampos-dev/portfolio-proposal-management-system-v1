package com.io.proposal.management.repository;

import com.io.proposal.management.domain.entity.ProposalEntity;
import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProposalRepository extends JpaRepository<ProposalEntity, String> {

    @NonNull Optional<ProposalEntity> findById(@NonNull String id);

    default ProposalEntity findByIdOrElseThrow(String id){
        return this.findById(id).orElseThrow(() -> new NullPointerException("Proposta não encontrada com esse id"));
    }

}
