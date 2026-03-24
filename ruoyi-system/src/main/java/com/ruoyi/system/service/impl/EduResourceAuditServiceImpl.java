package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.domain.EduResourceAudit;
import com.ruoyi.system.mapper.EduResourceAuditMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.service.IEduMessageService;
import com.ruoyi.system.service.IEduResourceAuditService;

@Service
public class EduResourceAuditServiceImpl implements IEduResourceAuditService
{
    @Autowired
    private EduResourceAuditMapper auditMapper;

    @Autowired
    private EduResourceMapper resourceMapper;

    @Autowired
    private IEduMessageService messageService;

    @Override
    public List<EduResourceAudit> selectAuditList(EduResourceAudit audit)
    {
        return auditMapper.selectAuditList(audit);
    }

    @Override
    public EduResourceAudit selectAuditById(Long auditId)
    {
        return auditMapper.selectAuditById(auditId);
    }

    @Override
    @Transactional
    public int passAudit(EduResourceAudit audit)
    {
        EduResourceAudit dbAudit = auditMapper.selectAuditById(audit.getAuditId());
        checkPendingAudit(dbAudit);
        fillAuditInfo(audit, dbAudit, "approved");
        auditMapper.updateAudit(audit);
        int rows = resourceMapper.updateResourceStatus(dbAudit.getResourceId(), "approved", "published");
        EduResource resource = resourceMapper.selectResourceById(dbAudit.getResourceId());
        if (resource != null && resource.getUploaderId() != null)
        {
            messageService.sendMessage(resource.getUploaderId(), resource.getUploaderName(), "资源审核通知",
                "您上传的资源《" + resource.getResourceTitle() + "》已审核通过并成功上架。", "audit", resource.getResourceId());
        }
        return rows;
    }

    @Override
    @Transactional
    public int rejectAudit(EduResourceAudit audit)
    {
        EduResourceAudit dbAudit = auditMapper.selectAuditById(audit.getAuditId());
        checkPendingAudit(dbAudit);
        fillAuditInfo(audit, dbAudit, "rejected");
        auditMapper.updateAudit(audit);
        int rows = resourceMapper.updateResourceStatus(dbAudit.getResourceId(), "rejected", "rejected");
        EduResource resource = resourceMapper.selectResourceById(dbAudit.getResourceId());
        if (resource != null && resource.getUploaderId() != null)
        {
            messageService.sendMessage(resource.getUploaderId(), resource.getUploaderName(), "资源审核通知",
                "您上传的资源《" + resource.getResourceTitle() + "》审核未通过，原因：" + StringUtils.defaultIfBlank(audit.getAuditReason(), "请根据要求完善后重新提交"),
                "audit", resource.getResourceId());
        }
        return rows;
    }

    @Override
    @Transactional
    public int offlineResource(EduResourceAudit audit)
    {
        EduResource resource = resourceMapper.selectResourceById(audit.getResourceId());
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        EduResourceAudit record = new EduResourceAudit();
        record.setResourceId(resource.getResourceId());
        record.setResourceTitle(resource.getResourceTitle());
        record.setAuditStatus("offline");
        record.setAuditReason(StringUtils.defaultIfBlank(audit.getAuditReason(), "人工下架"));
        record.setAuditorId(SecurityUtils.getUserId());
        record.setAuditorName(SecurityUtils.getUsername());
        record.setAuditTime(new Date());
        record.setCreateBy(SecurityUtils.getUsername());
        auditMapper.insertAudit(record);
        int rows = resourceMapper.updateResourceStatus(resource.getResourceId(), resource.getAuditStatus(), "offline");
        if (resource.getUploaderId() != null)
        {
            messageService.sendMessage(resource.getUploaderId(), resource.getUploaderName(), "资源下架通知",
                "您上传的资源《" + resource.getResourceTitle() + "》已被下架，请及时处理。", "audit", resource.getResourceId());
        }
        return rows;
    }

    private void fillAuditInfo(EduResourceAudit audit, EduResourceAudit dbAudit, String status)
    {
        audit.setResourceId(dbAudit.getResourceId());
        audit.setResourceTitle(dbAudit.getResourceTitle());
        audit.setAuditStatus(status);
        audit.setAuditorId(SecurityUtils.getUserId());
        audit.setAuditorName(SecurityUtils.getUsername());
        audit.setAuditTime(new Date());
        audit.setUpdateBy(SecurityUtils.getUsername());
    }

    private void checkPendingAudit(EduResourceAudit audit)
    {
        if (audit == null)
        {
            throw new ServiceException("审核记录不存在");
        }
        if (!"pending".equals(audit.getAuditStatus()))
        {
            throw new ServiceException("该审核记录已处理");
        }
    }
}
