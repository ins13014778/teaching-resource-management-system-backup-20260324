package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.EduUserQuota;
import com.ruoyi.system.mapper.EduUserQuotaMapper;
import com.ruoyi.system.service.IEduUserQuotaService;

@Service
public class EduUserQuotaServiceImpl implements IEduUserQuotaService
{
    @Autowired
    private EduUserQuotaMapper quotaMapper;

    @Override
    public List<EduUserQuota> selectQuotaList(EduUserQuota quota)
    {
        return quotaMapper.selectQuotaList(quota);
    }

    @Override
    public EduUserQuota selectQuotaById(Long quotaId)
    {
        return quotaMapper.selectQuotaById(quotaId);
    }

    @Override
    public int updateQuota(EduUserQuota quota)
    {
        quotaMapper.updateUserStatus(quota);
        return quotaMapper.updateQuota(quota);
    }
}
