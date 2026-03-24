package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.AiAuditResult;

public interface IAiAuditResultService
{
    List<AiAuditResult> selectAuditResultList(AiAuditResult result);

    AiAuditResult selectAuditResultById(Long resultId);

    AiAuditResult selectAuditResultByResourceId(Long resourceId);

    int saveAuditResult(AiAuditResult result);

    int deleteAuditResultByIds(Long[] resultIds);
}
