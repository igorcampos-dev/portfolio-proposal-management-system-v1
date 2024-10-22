package com.io.proposal.management.repository;

import com.io.proposal.management.domain.entity.ClientsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClientsRepository extends JpaRepository<ClientsEntity, String> {

    default ClientsEntity findByIdOrElseThrow(String id){
        return this.findById(id).orElseThrow( () -> new NullPointerException("Cliente não encontrado com esse id."));
    }

    boolean existsByDocument(String document);

    ClientsEntity findByDocument(String document);
}
