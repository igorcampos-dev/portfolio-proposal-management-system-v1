package com.io.proposal.processor.service;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.queue.producer.ProposalUpdateProducer;
import com.io.proposal.processor.rule.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProposalsService {

    private final List<ProposalRule> rules =
            List.of(new ExpiredRule(),
                    new RejectedRule(),
                    new ManualApprovalRule(),
                    new ApprovedRule());

    private final ProposalUpdateProducer managementProducer;

    public void process(ProposalDto dto) {
        log.info("Starting the process of applying rules to the proposal...");
        var update = this.applyRules(dto);
        log.info("Rules validated successfully.");
        managementProducer.publishMessage(update);
    }

    private ProposalUpdateBo applyRules(ProposalDto dto){
        ProposalUpdateBo update = null;
        for (ProposalRule rule : rules) {
            update = rule.apply(dto);
            if (update != null) break;
        }
        return update;
    }

}