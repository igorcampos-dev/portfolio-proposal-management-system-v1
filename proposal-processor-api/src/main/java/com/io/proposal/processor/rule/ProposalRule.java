package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;

public interface ProposalRule {
    ProposalUpdateBo apply(ProposalDto dto);
}
