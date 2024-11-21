package com.io.proposal.management.domain.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ProposalSaveRequest(

        @NotNull(message = "A descrição não pode ser nula")
        @Size(max = 1000, message = "A descrição deve ter no máximo 1000 caracteres")
        String description,

        @NotNull(message = "O valor não pode ser nulo")
        @DecimalMin(value = "0.0", inclusive = false, message = "O valor deve ser maior que zero")
        @Digits(integer = 15, fraction = 2, message = "O valor deve ter no máximo 15 dígitos inteiros e 2 casas decimais")
        BigDecimal value,

        @NotNull(message = "O ID do fornecedor não pode ser nulo")
        @Size(max = 50, message = "O ID do fornecedor deve ter no máximo 50 caracteres")
        String supplierId,

        @NotNull(message = "O nome do fornecedor não pode ser nulo")
        @Size(max = 255, message = "O nome do fornecedor deve ter no máximo 255 caracteres")
        String supplierName,

        @NotNull(message = "O ID do cliente não pode ser nulo")
        @Size(max = 50, message = "O ID do cliente deve ter no máximo 50 caracteres")
        String clientId,

        @NotNull(message = "O nome do cliente não pode ser nulo")
        @Size(max = 255, message = "O nome do cliente deve ter no máximo 255 caracteres")
        String clientName,

        @NotNull(message = "A data de criação não pode ser nula")
        LocalDateTime createdAt

) {}
