package com.io.proposal.processor.queue.producer;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;

public interface ProposalUpdateProducer {
    void publishMessage(ProposalUpdateBo ProposalUpdate);
}
