package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduResourceAudit;

public interface EduResourceAuditMapper
{
    List<EduResourceAudit> selectAuditList(EduResourceAudit audit);

    EduResourceAudit selectAuditById(Long auditId);

    EduResourceAudit selectPendingAuditByResourceId(Long resourceId);

    int insertAudit(EduResourceAudit audit);

    int updateAudit(EduResourceAudit audit);
}
