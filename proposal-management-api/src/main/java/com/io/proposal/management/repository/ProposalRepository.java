package com.io.proposal.management.repository;

import com.io.proposal.management.domain.entity.ProposalEntity;
import com.io.proposal.management.domain.entity.fields.Status;
import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProposalRepository extends JpaRepository<ProposalEntity, String> {

    @NonNull Optional<ProposalEntity> findById(@NonNull String id);

    @Query("SELECT p FROM ProposalEntity p WHERE p.status = :status AND p.updatedAt < :currentTime")
    List<ProposalEntity> findPendingProposals(@Param("status") Status status, @Param("currentTime") LocalDateTime currentTime);

    default ProposalEntity findByIdOrElseThrow(String id){
        return this.findById(id).orElseThrow(() -> new NullPointerException("Proposta não encontrada com esse id"));
    }

}
