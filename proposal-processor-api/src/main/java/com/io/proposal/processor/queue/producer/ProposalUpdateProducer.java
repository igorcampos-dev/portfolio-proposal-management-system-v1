package com.io.proposal.processor.queue.producer;

import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;

public interface ProposalUpdateProducer {
    void publishMessage(ProposalUpdateInternal ProposalUpdate);
}
