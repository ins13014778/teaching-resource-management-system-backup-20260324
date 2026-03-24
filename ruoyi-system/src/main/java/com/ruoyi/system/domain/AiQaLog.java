package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class AiQaLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long qaId;
    private Long userId;
    private String userName;
    private String question;
    private String answer;
    private String referenceResourceIds;
    private String referenceTitles;
    private String modelName;
    private Long costMillis;

    public Long getQaId() { return qaId; }
    public void setQaId(Long qaId) { this.qaId = qaId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }
    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
    public String getReferenceResourceIds() { return referenceResourceIds; }
    public void setReferenceResourceIds(String referenceResourceIds) { this.referenceResourceIds = referenceResourceIds; }
    public String getReferenceTitles() { return referenceTitles; }
    public void setReferenceTitles(String referenceTitles) { this.referenceTitles = referenceTitles; }
    public String getModelName() { return modelName; }
    public void setModelName(String modelName) { this.modelName = modelName; }
    public Long getCostMillis() { return costMillis; }
    public void setCostMillis(Long costMillis) { this.costMillis = costMillis; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("qaId", getQaId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("question", getQuestion())
            .append("answer", getAnswer())
            .append("referenceResourceIds", getReferenceResourceIds())
            .append("referenceTitles", getReferenceTitles())
            .append("modelName", getModelName())
            .append("costMillis", getCostMillis())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("remark", getRemark())
            .toString();
    }
}
