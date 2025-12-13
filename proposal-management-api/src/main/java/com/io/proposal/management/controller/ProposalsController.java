package com.io.proposal.management.controller;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.service.ProposalsService;
import jakarta.validation.Valid;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(path = ProposalsController.PATH)
public class ProposalsController {

    public static final String PATH = "/v1/proposals";
    private final ProposalsService service;

    @PostMapping
    public ResponseEntity<@NonNull ProposalSaveResponse> saveProposal(@Valid @RequestBody ProposalSaveRequest dto){
        log.info("Iniciando processo de cadastro de uma proposta...");
        var response = service.saveProposal(dto);
        log.info("Processo de cadastro de uma proposta finalizado com sucesso.");
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping
    public ResponseEntity<@NonNull ProposalUpdateResponse> updateProposal(@Valid @RequestBody ProposalUpdateRequest dto){
        log.info("Iniciando processo de atualização de uma proposta...");
        var response = service.updateProposal(dto);
        log.info("Processo de atualização de uma proposta finalizado com sucesso.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

}
