package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduResourceLike extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long likeId;
    private Long resourceId;
    private String resourceTitle;
    private Long userId;
    private String userName;

    public Long getLikeId() { return likeId; }
    public void setLikeId(Long likeId) { this.likeId = likeId; }
    public Long getResourceId() { return resourceId; }
    public void setResourceId(Long resourceId) { this.resourceId = resourceId; }
    public String getResourceTitle() { return resourceTitle; }
    public void setResourceTitle(String resourceTitle) { this.resourceTitle = resourceTitle; }
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("likeId", getLikeId())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("remark", getRemark())
            .toString();
    }
}
