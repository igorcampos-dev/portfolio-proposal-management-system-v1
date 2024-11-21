package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;

public interface ProposalRule {
    boolean applies(ProposalInternal proposal);
    ProposalUpdateInternal process(ProposalInternal proposal);
}
