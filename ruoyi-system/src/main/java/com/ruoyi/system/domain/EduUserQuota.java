package com.ruoyi.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduUserQuota extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long quotaId;
    private Long userId;
    private String userName;
    private String nickName;
    private String deptName;
    private String roleNames;
    private Integer storageGb;
    private Integer uploadMb;
    private BigDecimal usedStorageMb;
    private String status;
    private String allowShare;
    private String allowPasswordShare;
    private Integer maxShareDays;
    private String banReason;
    private String userStatus;

    public Long getQuotaId()
    {
        return quotaId;
    }

    public void setQuotaId(Long quotaId)
    {
        this.quotaId = quotaId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getNickName()
    {
        return nickName;
    }

    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getDeptName()
    {
        return deptName;
    }

    public void setDeptName(String deptName)
    {
        this.deptName = deptName;
    }

    public String getRoleNames()
    {
        return roleNames;
    }

    public void setRoleNames(String roleNames)
    {
        this.roleNames = roleNames;
    }

    public Integer getStorageGb()
    {
        return storageGb;
    }

    public void setStorageGb(Integer storageGb)
    {
        this.storageGb = storageGb;
    }

    public Integer getUploadMb()
    {
        return uploadMb;
    }

    public void setUploadMb(Integer uploadMb)
    {
        this.uploadMb = uploadMb;
    }

    public BigDecimal getUsedStorageMb()
    {
        return usedStorageMb;
    }

    public void setUsedStorageMb(BigDecimal usedStorageMb)
    {
        this.usedStorageMb = usedStorageMb;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getAllowShare()
    {
        return allowShare;
    }

    public void setAllowShare(String allowShare)
    {
        this.allowShare = allowShare;
    }

    public String getAllowPasswordShare()
    {
        return allowPasswordShare;
    }

    public void setAllowPasswordShare(String allowPasswordShare)
    {
        this.allowPasswordShare = allowPasswordShare;
    }

    public Integer getMaxShareDays()
    {
        return maxShareDays;
    }

    public void setMaxShareDays(Integer maxShareDays)
    {
        this.maxShareDays = maxShareDays;
    }

    public String getBanReason()
    {
        return banReason;
    }

    public void setBanReason(String banReason)
    {
        this.banReason = banReason;
    }

    public String getUserStatus()
    {
        return userStatus;
    }

    public void setUserStatus(String userStatus)
    {
        this.userStatus = userStatus;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("quotaId", getQuotaId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("nickName", getNickName())
            .append("deptName", getDeptName())
            .append("roleNames", getRoleNames())
            .append("storageGb", getStorageGb())
            .append("uploadMb", getUploadMb())
            .append("usedStorageMb", getUsedStorageMb())
            .append("status", getStatus())
            .append("allowShare", getAllowShare())
            .append("allowPasswordShare", getAllowPasswordShare())
            .append("maxShareDays", getMaxShareDays())
            .append("banReason", getBanReason())
            .append("userStatus", getUserStatus())
            .append("remark", getRemark())
            .toString();
    }
}
