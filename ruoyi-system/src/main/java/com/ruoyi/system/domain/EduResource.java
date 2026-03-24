package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduResource extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long resourceId;

    private String resourceTitle;

    private String resourceType;

    private String categoryName;

    private String courseName;

    private String tagNames;

    private String fileUrl;

    private String coverUrl;

    private String resourceVersion;

    private BigDecimal fileSizeMb;

    private Long uploaderId;

    private String uploaderName;

    private String auditStatus;

    private String publishStatus;

    private String recommendFlag;

    private Integer downloadCount;

    private Integer favoriteCount;

    private Integer likeCount;

    private String keyword;

    private String orderBy;

    private String resourceDesc;

    private String delFlag;

    private List<String> courseNameScope;

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

    public String getTagNames()
    {
        return tagNames;
    }

    public void setTagNames(String tagNames)
    {
        this.tagNames = tagNames;
    }

    public String getFileUrl()
    {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl)
    {
        this.fileUrl = fileUrl;
    }

    public String getCoverUrl()
    {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl)
    {
        this.coverUrl = coverUrl;
    }

    public String getResourceVersion()
    {
        return resourceVersion;
    }

    public void setResourceVersion(String resourceVersion)
    {
        this.resourceVersion = resourceVersion;
    }

    public BigDecimal getFileSizeMb()
    {
        return fileSizeMb;
    }

    public void setFileSizeMb(BigDecimal fileSizeMb)
    {
        this.fileSizeMb = fileSizeMb;
    }

    public Long getUploaderId()
    {
        return uploaderId;
    }

    public void setUploaderId(Long uploaderId)
    {
        this.uploaderId = uploaderId;
    }

    public String getUploaderName()
    {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName)
    {
        this.uploaderName = uploaderName;
    }

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

    public String getPublishStatus()
    {
        return publishStatus;
    }

    public void setPublishStatus(String publishStatus)
    {
        this.publishStatus = publishStatus;
    }

    public String getRecommendFlag()
    {
        return recommendFlag;
    }

    public void setRecommendFlag(String recommendFlag)
    {
        this.recommendFlag = recommendFlag;
    }

    public Integer getDownloadCount()
    {
        return downloadCount;
    }

    public void setDownloadCount(Integer downloadCount)
    {
        this.downloadCount = downloadCount;
    }

    public Integer getFavoriteCount()
    {
        return favoriteCount;
    }

    public void setFavoriteCount(Integer favoriteCount)
    {
        this.favoriteCount = favoriteCount;
    }

    public Integer getLikeCount()
    {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount)
    {
        this.likeCount = likeCount;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public void setKeyword(String keyword)
    {
        this.keyword = keyword;
    }

    public String getOrderBy()
    {
        return orderBy;
    }

    public void setOrderBy(String orderBy)
    {
        this.orderBy = orderBy;
    }

    public String getResourceDesc()
    {
        return resourceDesc;
    }

    public void setResourceDesc(String resourceDesc)
    {
        this.resourceDesc = resourceDesc;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public List<String> getCourseNameScope()
    {
        return courseNameScope;
    }

    public void setCourseNameScope(List<String> courseNameScope)
    {
        this.courseNameScope = courseNameScope;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("resourceType", getResourceType())
            .append("categoryName", getCategoryName())
            .append("courseName", getCourseName())
            .append("tagNames", getTagNames())
            .append("fileUrl", getFileUrl())
            .append("coverUrl", getCoverUrl())
            .append("resourceVersion", getResourceVersion())
            .append("fileSizeMb", getFileSizeMb())
            .append("uploaderId", getUploaderId())
            .append("uploaderName", getUploaderName())
            .append("auditStatus", getAuditStatus())
            .append("publishStatus", getPublishStatus())
            .append("recommendFlag", getRecommendFlag())
            .append("downloadCount", getDownloadCount())
            .append("favoriteCount", getFavoriteCount())
            .append("likeCount", getLikeCount())
            .append("keyword", getKeyword())
            .append("orderBy", getOrderBy())
            .append("resourceDesc", getResourceDesc())
            .append("delFlag", getDelFlag())
            .append("courseNameScope", getCourseNameScope())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
