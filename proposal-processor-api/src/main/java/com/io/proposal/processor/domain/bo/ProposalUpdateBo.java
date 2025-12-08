package com.io.proposal.processor.domain.bo;

import com.io.proposal.processor.domain.dto.ProposalDto;
import com.io.proposal.processor.domain.fields.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProposalUpdateBo {
    private String id;
    private Status status;
    private String analysisDescription;

    public static ProposalUpdateBo build(String id, Status status, String reason) {
        return ProposalUpdateBo.builder()
                               .id(id)
                               .status(status)
                               .analysisDescription(reason)
                               .build();
    }

}
