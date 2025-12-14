package com.io.proposal.management.domain.bo;

import com.io.proposal.management.domain.entity.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposalUpdateBo {
    private String id;
    private Status status;
    private String analysisDescription;
}
