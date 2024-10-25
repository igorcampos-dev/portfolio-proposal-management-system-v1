package com.io.proposal.management.runner;

import com.io.proposal.management.domain.entity.ClientsEntity;
import com.io.proposal.management.domain.entity.fields.LoyaltyLevel;
import com.io.proposal.management.repository.ClientsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@Profile({"default", "dev"})
@RequiredArgsConstructor
@SuppressWarnings("unused")
public class init implements CommandLineRunner {

    private final ClientsRepository clientsRepository;

    @Override
    public void run(String... args) {

        ClientsEntity entity = ClientsEntity.builder()
                .name("default user")
                .document("13326432054")
                .level(LoyaltyLevel.PLATINUM)
                .build();

        var entityDatabase = clientsRepository.findByDocument(entity.getDocument());

        if (entityDatabase == null){
            var entityResponse = clientsRepository.save(entity);
            log.info("user default created: {}", entity);
        } else {
            log.info("user default already exists: {}", entityDatabase);
        }

    }

}
