package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduUserQuota;

public interface EduUserQuotaMapper
{
    List<EduUserQuota> selectQuotaList(EduUserQuota quota);

    EduUserQuota selectQuotaById(Long quotaId);

    int insertQuota(EduUserQuota quota);

    int updateQuota(EduUserQuota quota);

    int updateUserStatus(EduUserQuota quota);
}
