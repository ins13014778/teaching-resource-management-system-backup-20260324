package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduUserQuota;

public interface IEduUserQuotaService
{
    List<EduUserQuota> selectQuotaList(EduUserQuota quota);

    EduUserQuota selectQuotaById(Long quotaId);

    int updateQuota(EduUserQuota quota);
}
