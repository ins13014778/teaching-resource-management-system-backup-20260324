package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduResourceAudit;

public interface IEduResourceAuditService
{
    List<EduResourceAudit> selectAuditList(EduResourceAudit audit);

    EduResourceAudit selectAuditById(Long auditId);

    int passAudit(EduResourceAudit audit);

    int rejectAudit(EduResourceAudit audit);

    int offlineResource(EduResourceAudit audit);
}
