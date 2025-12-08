package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.fields.Status;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class ExpiredRule implements ProposalRule {

    @Override
    public ProposalUpdateBo apply(ProposalDto dto) {
        if (ChronoUnit.DAYS.between(dto.updatedAt(), LocalDateTime.now()) >= 30) {
            return ProposalUpdateBo.build(dto.id(), Status.EXPIRED, "Contract is expired, exceeded the 30-day limit");
        }
        return null;
    }
}
