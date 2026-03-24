package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduReport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long reportId;
    private String reportType;
    private Long targetId;
    private String targetTitle;
    private Long reporterId;
    private String reporterName;
    private String reasonType;
    private String reportContent;
    private String status;
    private String handleResult;
    private Long handlerId;
    private String handlerName;
    private String delFlag;

    public Long getReportId() { return reportId; }
    public void setReportId(Long reportId) { this.reportId = reportId; }
    public String getReportType() { return reportType; }
    public void setReportType(String reportType) { this.reportType = reportType; }
    public Long getTargetId() { return targetId; }
    public void setTargetId(Long targetId) { this.targetId = targetId; }
    public String getTargetTitle() { return targetTitle; }
    public void setTargetTitle(String targetTitle) { this.targetTitle = targetTitle; }
    public Long getReporterId() { return reporterId; }
    public void setReporterId(Long reporterId) { this.reporterId = reporterId; }
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }
    public String getReasonType() { return reasonType; }
    public void setReasonType(String reasonType) { this.reasonType = reasonType; }
    public String getReportContent() { return reportContent; }
    public void setReportContent(String reportContent) { this.reportContent = reportContent; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getHandleResult() { return handleResult; }
    public void setHandleResult(String handleResult) { this.handleResult = handleResult; }
    public Long getHandlerId() { return handlerId; }
    public void setHandlerId(Long handlerId) { this.handlerId = handlerId; }
    public String getHandlerName() { return handlerName; }
    public void setHandlerName(String handlerName) { this.handlerName = handlerName; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("reportId", getReportId())
            .append("reportType", getReportType())
            .append("targetId", getTargetId())
            .append("targetTitle", getTargetTitle())
            .append("reporterId", getReporterId())
            .append("reporterName", getReporterName())
            .append("reasonType", getReasonType())
            .append("reportContent", getReportContent())
            .append("status", getStatus())
            .append("handleResult", getHandleResult())
            .append("handlerId", getHandlerId())
            .append("handlerName", getHandlerName())
            .append("delFlag", getDelFlag())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
