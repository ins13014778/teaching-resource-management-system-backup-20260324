package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AiAuditResult;

public interface AiAuditResultMapper
{
    List<AiAuditResult> selectAuditResultList(AiAuditResult result);

    AiAuditResult selectAuditResultById(Long resultId);

    AiAuditResult selectAuditResultByResourceId(Long resourceId);

    int insertAuditResult(AiAuditResult result);

    int updateAuditResult(AiAuditResult result);

    int deleteAuditResultByIds(Long[] resultIds);
}
