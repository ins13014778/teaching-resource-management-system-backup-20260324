package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduResourceAudit extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long auditId;

    private Long resourceId;

    private String resourceTitle;

    private String auditStatus;

    private String auditReason;

    private Long auditorId;

    private String auditorName;

    private Date auditTime;

    private String resourceType;

    private String categoryName;

    private String courseName;

    private String uploaderName;

    private String publishStatus;

    public Long getAuditId()
    {
        return auditId;
    }

    public void setAuditId(Long auditId)
    {
        this.auditId = auditId;
    }

    public Long getResourceId()
    {
        return resourceId;
    }

    public void setResourceId(Long resourceId)
    {
        this.resourceId = resourceId;
    }

    public String getResourceTitle()
    {
        return resourceTitle;
    }

    public void setResourceTitle(String resourceTitle)
    {
        this.resourceTitle = resourceTitle;
    }

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

    public String getAuditReason()
    {
        return auditReason;
    }

    public void setAuditReason(String auditReason)
    {
        this.auditReason = auditReason;
    }

    public Long getAuditorId()
    {
        return auditorId;
    }

    public void setAuditorId(Long auditorId)
    {
        this.auditorId = auditorId;
    }

    public String getAuditorName()
    {
        return auditorName;
    }

    public void setAuditorName(String auditorName)
    {
        this.auditorName = auditorName;
    }

    public Date getAuditTime()
    {
        return auditTime;
    }

    public void setAuditTime(Date auditTime)
    {
        this.auditTime = auditTime;
    }

    public String getResourceType()
    {
        return resourceType;
    }

    public void setResourceType(String resourceType)
    {
        this.resourceType = resourceType;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public void setCourseName(String courseName)
    {
        this.courseName = courseName;
    }

    public String getUploaderName()
    {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName)
    {
        this.uploaderName = uploaderName;
    }

    public String getPublishStatus()
    {
        return publishStatus;
    }

    public void setPublishStatus(String publishStatus)
    {
        this.publishStatus = publishStatus;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("auditId", getAuditId())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("auditStatus", getAuditStatus())
            .append("auditReason", getAuditReason())
            .append("auditorId", getAuditorId())
            .append("auditorName", getAuditorName())
            .append("auditTime", getAuditTime())
            .append("resourceType", getResourceType())
            .append("categoryName", getCategoryName())
            .append("courseName", getCourseName())
            .append("uploaderName", getUploaderName())
            .append("publishStatus", getPublishStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
