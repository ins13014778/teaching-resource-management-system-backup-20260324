package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class AiEmbeddingIndex extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long indexId;
    private Long resourceId;
    private String resourceTitle;
    private String keywordText;
    private String summaryText;

    public Long getIndexId() { return indexId; }
    public void setIndexId(Long indexId) { this.indexId = indexId; }
    public Long getResourceId() { return resourceId; }
    public void setResourceId(Long resourceId) { this.resourceId = resourceId; }
    public String getResourceTitle() { return resourceTitle; }
    public void setResourceTitle(String resourceTitle) { this.resourceTitle = resourceTitle; }
    public String getKeywordText() { return keywordText; }
    public void setKeywordText(String keywordText) { this.keywordText = keywordText; }
    public String getSummaryText() { return summaryText; }
    public void setSummaryText(String summaryText) { this.summaryText = summaryText; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("indexId", getIndexId())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("keywordText", getKeywordText())
            .append("summaryText", getSummaryText())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
