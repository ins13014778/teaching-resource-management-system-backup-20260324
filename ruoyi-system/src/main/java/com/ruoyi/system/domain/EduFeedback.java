package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduFeedback extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long feedbackId;
    private Long userId;
    private String userName;
    private String title;
    private String content;
    private String contact;
    private String status;
    private String replyContent;
    private String replyBy;
    private Date replyTime;
    private String delFlag;

    public Long getFeedbackId() { return feedbackId; }
    public void setFeedbackId(Long feedbackId) { this.feedbackId = feedbackId; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getReplyContent() { return replyContent; }
    public void setReplyContent(String replyContent) { this.replyContent = replyContent; }
    public String getReplyBy() { return replyBy; }
    public void setReplyBy(String replyBy) { this.replyBy = replyBy; }
    public Date getReplyTime() { return replyTime; }
    public void setReplyTime(Date replyTime) { this.replyTime = replyTime; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("feedbackId", getFeedbackId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("title", getTitle())
            .append("content", getContent())
            .append("contact", getContact())
            .append("status", getStatus())
            .append("replyContent", getReplyContent())
            .append("replyBy", getReplyBy())
            .append("replyTime", getReplyTime())
            .append("delFlag", getDelFlag())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
