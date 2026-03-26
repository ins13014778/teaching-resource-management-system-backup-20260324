package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduSpaceShare extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long shareId;
    private Long ownerUserId;
    private String ownerName;
    private String shareName;
    private Long fileId;
    private String targetType;
    private String targetName;
    private String targetPath;
    private String shareMode;
    private String sharePassword;
    private Date expireTime;
    private Integer downloadLimit;
    private Integer downloadCount;
    private Integer viewCount;
    private String status;
    private String delFlag;

    public Long getShareId() { return shareId; }
    public void setShareId(Long shareId) { this.shareId = shareId; }
    public Long getOwnerUserId() { return ownerUserId; }
    public void setOwnerUserId(Long ownerUserId) { this.ownerUserId = ownerUserId; }
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public String getShareName() { return shareName; }
    public void setShareName(String shareName) { this.shareName = shareName; }
    public Long getFileId() { return fileId; }
    public void setFileId(Long fileId) { this.fileId = fileId; }
    public String getTargetType() { return targetType; }
    public void setTargetType(String targetType) { this.targetType = targetType; }
    public String getTargetName() { return targetName; }
    public void setTargetName(String targetName) { this.targetName = targetName; }
    public String getTargetPath() { return targetPath; }
    public void setTargetPath(String targetPath) { this.targetPath = targetPath; }
    public String getShareMode() { return shareMode; }
    public void setShareMode(String shareMode) { this.shareMode = shareMode; }
    public String getSharePassword() { return sharePassword; }
    public void setSharePassword(String sharePassword) { this.sharePassword = sharePassword; }
    public Date getExpireTime() { return expireTime; }
    public void setExpireTime(Date expireTime) { this.expireTime = expireTime; }
    public Integer getDownloadLimit() { return downloadLimit; }
    public void setDownloadLimit(Integer downloadLimit) { this.downloadLimit = downloadLimit; }
    public Integer getDownloadCount() { return downloadCount; }
    public void setDownloadCount(Integer downloadCount) { this.downloadCount = downloadCount; }
    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("shareId", getShareId())
            .append("ownerUserId", getOwnerUserId())
            .append("ownerName", getOwnerName())
            .append("shareName", getShareName())
            .append("fileId", getFileId())
            .append("targetType", getTargetType())
            .append("targetName", getTargetName())
            .append("targetPath", getTargetPath())
            .append("shareMode", getShareMode())
            .append("sharePassword", getSharePassword())
            .append("expireTime", getExpireTime())
            .append("downloadLimit", getDownloadLimit())
            .append("downloadCount", getDownloadCount())
            .append("viewCount", getViewCount())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("remark", getRemark())
            .toString();
    }
}