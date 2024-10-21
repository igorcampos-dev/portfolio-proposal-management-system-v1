package com.io.proposal.management.controller;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalDeleteResponse;
import com.io.proposal.management.domain.dto.response.ProposalGetListResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.service.ProposalsService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Size;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@SuppressWarnings("unused")
@RequestMapping(path = ProposalsController.PATH)
public class ProposalsController {

    public static final String PATH = "/v1/proposals";

    private final ProposalsService service;

    @PostMapping
    public ResponseEntity<ProposalSaveResponse> saveProposal(@Valid @RequestBody ProposalSaveRequest dto){
        var response = service.saveProposal(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProposalGetListResponse> getProposal(
            @Size(min = 36, max = 36, message = "O campo `id` deve ter exatos 36 caracteres.")
            @PathVariable(value = "id") String id,
            @RequestParam(value = "page", defaultValue = "0") int page
    ){

        var response = service.getProposal(page, id);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @PutMapping
    public ResponseEntity<ProposalUpdateResponse> updateProposal(@Valid @RequestBody ProposalUpdateRequest dto){
        var response = service.updateProposal(dto);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ProposalDeleteResponse> deleteProposal(
            @Size(min = 36, max = 36, message = "O campo `id` deve ter exatos 36 caracteres.")
            @PathVariable(value = "id") String id
    ){
        var response = service.deleteProposal(id);
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

}
