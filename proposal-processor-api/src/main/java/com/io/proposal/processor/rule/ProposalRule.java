package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalBo;
import com.io.proposal.processor.domain.bo.ProposalUpdateBo;

public interface ProposalRule {
    boolean applies(ProposalBo proposal);
    ProposalUpdateBo process(ProposalBo proposal);
}
