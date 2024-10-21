package com.io.proposal.management.domain.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record ProposalUpdateRequest(

        @NotNull(message = "O campo `userId` não pode ser nulo.")
        @Size(min = 36, max = 36, message = "O campo `userId` deve ter exatos 36 caracteres.")
        String userId,

        @NotNull(message = "O campo `proposalId` não pode ser nulo.")
        @Size(min = 36, max = 36, message = "O campo `proposalId` deve ter exatos 36 caracteres.")
        String proposalId,

        @NotNull(message = "O campo `amount` não pode ser nulo.")
        @DecimalMin(value = "0.00", inclusive = false, message = "O valor deve ser maior que zero.")
        BigDecimal amount,

        @NotNull(message = "O campo `purpose` não pode ser nulo.")
        @Size(min = 10, max = 255, message = "O campo `purpose` deve ter no mínimo 10 caracteres e um máximo de 255 caracteres.")
        String purpose

) {}
