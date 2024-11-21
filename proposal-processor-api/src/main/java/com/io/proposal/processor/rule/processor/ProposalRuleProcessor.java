package com.io.proposal.processor.rule.processor;

import com.io.proposal.processor.domain.internal.ProposalInternal;
import com.io.proposal.processor.domain.internal.ProposalUpdateInternal;
import com.io.proposal.processor.rule.ProposalRule;
import com.io.proposal.processor.rule.impl.ExpiredProposalRule;
import com.io.proposal.processor.rule.impl.LowValueProposalRule;
import com.io.proposal.processor.rule.impl.ManualApprovalRule;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
@RequiredArgsConstructor
public class ProposalRuleProcessor {

    private final List<ProposalRule> rules = List.of(
        new ExpiredProposalRule(),
        new ManualApprovalRule(),
        new LowValueProposalRule()
    );

    public ProposalUpdateInternal process(ProposalInternal proposal) {
        for (ProposalRule rule : rules) {
            if (rule.applies(proposal)) {
                return rule.process(proposal);
            }
        }
        return ProposalUpdateInternal.setProposalProcessed(proposal.getId());
    }
}
