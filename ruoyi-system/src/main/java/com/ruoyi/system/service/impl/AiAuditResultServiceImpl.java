package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.AiAuditResult;
import com.ruoyi.system.mapper.AiAuditResultMapper;
import com.ruoyi.system.service.IAiAuditResultService;

@Service
public class AiAuditResultServiceImpl implements IAiAuditResultService
{
    @Autowired
    private AiAuditResultMapper auditResultMapper;

    @Override
    public List<AiAuditResult> selectAuditResultList(AiAuditResult result)
    {
        return auditResultMapper.selectAuditResultList(result);
    }

    @Override
    public AiAuditResult selectAuditResultById(Long resultId)
    {
        return auditResultMapper.selectAuditResultById(resultId);
    }

    @Override
    public AiAuditResult selectAuditResultByResourceId(Long resourceId)
    {
        return auditResultMapper.selectAuditResultByResourceId(resourceId);
    }

    @Override
    public int saveAuditResult(AiAuditResult result)
    {
        AiAuditResult db = auditResultMapper.selectAuditResultByResourceId(result.getResourceId());
        if (db == null)
        {
            return auditResultMapper.insertAuditResult(result);
        }
        result.setResultId(db.getResultId());
        if (result.getUpdateBy() == null)
        {
            result.setUpdateBy(SecurityUtils.getUsername());
        }
        return auditResultMapper.updateAuditResult(result);
    }

    @Override
    public int deleteAuditResultByIds(Long[] resultIds)
    {
        return auditResultMapper.deleteAuditResultByIds(resultIds);
    }
}
