package com.io.proposal.processor.rule;

import com.io.proposal.processor.domain.bo.ProposalUpdateBo;
import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.fields.ClientType;
import com.io.proposal.processor.domain.fields.PaymentModel;
import com.io.proposal.processor.domain.fields.RiskCategory;
import com.io.proposal.processor.domain.fields.Status;
import java.math.BigDecimal;

public class RejectedRule implements ProposalRule {

    @Override
    public ProposalUpdateBo apply(ProposalDto dto) {
        if (dto.riskCategory() == RiskCategory.HIGH && dto.slaHours() > 24) {
            return ProposalUpdateBo.build(dto.id(), Status.REJECTED, "High-risk contract requires SLA to be less than 24 hours");
        }
        if (dto.requiresOnSite() && dto.durationMonths() < 6) {
            return ProposalUpdateBo.build(dto.id(), Status.REJECTED, "On-site contracts have operational costs, must be longer than 6 months");
        }
        if (BigDecimal.valueOf(100_000).compareTo(dto.contractValue()) < 0 && ClientType.PF.equals(dto.clientType())) {
            return ProposalUpdateBo.build(dto.id(), Status.REJECTED, "Contracts above 100k must be for corporate clients (PJ)");
        }
        if (PaymentModel.MONTHLY.equals(dto.paymentModel()) && dto.durationMonths() < 3) {
            return ProposalUpdateBo.build(dto.id(), Status.REJECTED, "Monthly payment requires a minimum duration of 3 months");
        }
        return null;
    }


}
