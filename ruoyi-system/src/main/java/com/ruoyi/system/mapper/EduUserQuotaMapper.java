package com.ruoyi.system.mapper;

import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduUserQuota;

public interface EduUserQuotaMapper
{
    List<EduUserQuota> selectQuotaList(EduUserQuota quota);

    EduUserQuota selectQuotaById(Long quotaId);

    EduUserQuota selectQuotaByUserId(Long userId);

    int insertQuota(EduUserQuota quota);

    int updateQuota(EduUserQuota quota);

    int updateUserStatus(EduUserQuota quota);

    int updateUsedStorageByUserId(@Param("userId") Long userId, @Param("deltaMb") BigDecimal deltaMb);
}