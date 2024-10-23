package com.io.proposal.processor.domain.dto;

import com.io.proposal.processor.domain.dto.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProposalDto {

    private String proposalId;
    private String clientName;
    private String clientDocument;
    private BigDecimal amount;
    private String purpose;
    private LocalDateTime creationDate;
    private Status status;

}
