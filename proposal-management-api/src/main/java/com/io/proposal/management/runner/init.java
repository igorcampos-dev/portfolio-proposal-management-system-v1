package com.io.proposal.management.runner;

import com.io.proposal.management.domain.entity.ClientsEntity;
import com.io.proposal.management.repository.ClientsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.util.UUID;

@Slf4j
@Component
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class init implements CommandLineRunner {

    private final ClientsRepository clientsRepository;

    @Override
    public void run(String... args) {

        ClientsEntity entity = ClientsEntity.builder()
                .clientId(UUID.randomUUID().toString())
                .name("default user")
                .document("13326432054")
                .build();


        if (!this.clientsRepository.existsByDocument(entity.getDocument())){
            clientsRepository.save(entity);
            log.warn("Cliente default atualizado na base de dados, esta classe deve ser removida em produção.");
        }

    }

}
