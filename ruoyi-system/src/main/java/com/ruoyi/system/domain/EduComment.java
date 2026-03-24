package com.ruoyi.system.domain;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long commentId;
    private Long resourceId;
    private String resourceTitle;
    private Long userId;
    private String userName;
    private Long parentId;
    private String parentUserName;
    private String content;
    private String auditStatus;
    private Integer likeCount;
    private String status;
    private String delFlag;
    private List<EduComment> children;

    public Long getCommentId() { return commentId; }
    public void setCommentId(Long commentId) { this.commentId = commentId; }
    public Long getResourceId() { return resourceId; }
    public void setResourceId(Long resourceId) { this.resourceId = resourceId; }
    public String getResourceTitle() { return resourceTitle; }
    public void setResourceTitle(String resourceTitle) { this.resourceTitle = resourceTitle; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public Long getParentId() { return parentId; }
    public void setParentId(Long parentId) { this.parentId = parentId; }
    public String getParentUserName() { return parentUserName; }
    public void setParentUserName(String parentUserName) { this.parentUserName = parentUserName; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getAuditStatus() { return auditStatus; }
    public void setAuditStatus(String auditStatus) { this.auditStatus = auditStatus; }
    public Integer getLikeCount() { return likeCount; }
    public void setLikeCount(Integer likeCount) { this.likeCount = likeCount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public List<EduComment> getChildren() { return children; }
    public void setChildren(List<EduComment> children) { this.children = children; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("commentId", getCommentId())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("parentId", getParentId())
            .append("parentUserName", getParentUserName())
            .append("content", getContent())
            .append("auditStatus", getAuditStatus())
            .append("likeCount", getLikeCount())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
