package com.ruoyi.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class AiAuditResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long resultId;
    private Long resourceId;
    private String resourceTitle;
    private BigDecimal riskScore;
    private BigDecimal duplicateScore;
    private String complianceLevel;
    private String hitWords;
    private String suggestion;
    private String auditSummary;
    private String status;
    private String rawResult;

    public Long getResultId() { return resultId; }
    public void setResultId(Long resultId) { this.resultId = resultId; }
    public Long getResourceId() { return resourceId; }
    public void setResourceId(Long resourceId) { this.resourceId = resourceId; }
    public String getResourceTitle() { return resourceTitle; }
    public void setResourceTitle(String resourceTitle) { this.resourceTitle = resourceTitle; }
    public BigDecimal getRiskScore() { return riskScore; }
    public void setRiskScore(BigDecimal riskScore) { this.riskScore = riskScore; }
    public BigDecimal getDuplicateScore() { return duplicateScore; }
    public void setDuplicateScore(BigDecimal duplicateScore) { this.duplicateScore = duplicateScore; }
    public String getComplianceLevel() { return complianceLevel; }
    public void setComplianceLevel(String complianceLevel) { this.complianceLevel = complianceLevel; }
    public String getHitWords() { return hitWords; }
    public void setHitWords(String hitWords) { this.hitWords = hitWords; }
    public String getSuggestion() { return suggestion; }
    public void setSuggestion(String suggestion) { this.suggestion = suggestion; }
    public String getAuditSummary() { return auditSummary; }
    public void setAuditSummary(String auditSummary) { this.auditSummary = auditSummary; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getRawResult() { return rawResult; }
    public void setRawResult(String rawResult) { this.rawResult = rawResult; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("resultId", getResultId())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("riskScore", getRiskScore())
            .append("duplicateScore", getDuplicateScore())
            .append("complianceLevel", getComplianceLevel())
            .append("hitWords", getHitWords())
            .append("suggestion", getSuggestion())
            .append("auditSummary", getAuditSummary())
            .append("status", getStatus())
            .append("rawResult", getRawResult())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
