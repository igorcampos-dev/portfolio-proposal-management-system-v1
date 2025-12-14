package com.io.proposal.management.controller;

import com.io.proposal.management.domain.dto.request.ProposalSaveRequest;
import com.io.proposal.management.domain.dto.request.ProposalUpdateRequest;
import com.io.proposal.management.domain.dto.response.ProposalGetByIdResponse;
import com.io.proposal.management.domain.dto.response.ProposalSaveResponse;
import com.io.proposal.management.domain.dto.response.ProposalUpdateResponse;
import com.io.proposal.management.service.ProposalsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
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
@Tag(
        name = "Proposals",
        description = "Endpoints for Service Contract processing"
)
public class ProposalsController {

    public static final String PATH = "/v1/proposals";
    private final ProposalsService service;

    @PostMapping
    @SecurityRequirement(name = "bearerAuth")
    @Operation(
            summary = "Create new proposal",
            description = "Creates a new service contract proposal.",
            security = @SecurityRequirement(name = "bearerAuth")
    )
    public ResponseEntity<@NonNull ProposalSaveResponse> saveProposal(
            @Valid @RequestBody ProposalSaveRequest dto
    ) {
        log.info("Starting proposal creation process...");
        var response = service.saveProposal(dto);
        log.info("Proposal creation process completed successfully.");
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PutMapping
    @SecurityRequirement(name = "bearerAuth")
    @Operation(
            summary = "Update existing proposal",
            description = "Updates the data of a previously registered proposal.",
            security = @SecurityRequirement(name = "bearerAuth")
    )
    public ResponseEntity<@NonNull ProposalUpdateResponse> updateProposal(
            @Valid @RequestBody ProposalUpdateRequest dto
    ) {
        log.info("Starting proposal update process...");
        var response = service.updateProposal(dto);
        log.info("Proposal update process completed successfully.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    @GetMapping("/{id}")
    @SecurityRequirement(name = "bearerAuth")
    @Operation(
            summary = "Get proposal by ID",
            description = "Returns the complete data of a proposal by its identifier.",
            security = @SecurityRequirement(name = "bearerAuth")
    )
    public ResponseEntity<@NonNull ProposalGetByIdResponse> getProposalById(
            @PathVariable("id") String id
    ) {
        log.info("Starting proposal retrieval process using id: {}", id);
        var response = service.findById(id);
        log.info("Proposal retrieval process completed successfully.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

}
