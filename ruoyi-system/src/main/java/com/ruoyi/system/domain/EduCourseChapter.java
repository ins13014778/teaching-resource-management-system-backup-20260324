package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduCourseChapter extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long chapterId;
    private Long courseId;
    private String courseName;
    private String chapterTitle;
    private String chapterIntro;
    private Integer orderNum;
    private Integer resourceCount;
    private String attachmentUrl;
    private String attachmentName;
    private java.math.BigDecimal attachmentSizeMb;
    private String status;
    private String delFlag;

    public Long getChapterId() { return chapterId; }
    public void setChapterId(Long chapterId) { this.chapterId = chapterId; }
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getChapterTitle() { return chapterTitle; }
    public void setChapterTitle(String chapterTitle) { this.chapterTitle = chapterTitle; }
    public String getChapterIntro() { return chapterIntro; }
    public void setChapterIntro(String chapterIntro) { this.chapterIntro = chapterIntro; }
    public Integer getOrderNum() { return orderNum; }
    public void setOrderNum(Integer orderNum) { this.orderNum = orderNum; }
    public Integer getResourceCount() { return resourceCount; }
    public void setResourceCount(Integer resourceCount) { this.resourceCount = resourceCount; }
    public String getAttachmentUrl() { return attachmentUrl; }
    public void setAttachmentUrl(String attachmentUrl) { this.attachmentUrl = attachmentUrl; }
    public String getAttachmentName() { return attachmentName; }
    public void setAttachmentName(String attachmentName) { this.attachmentName = attachmentName; }
    public java.math.BigDecimal getAttachmentSizeMb() { return attachmentSizeMb; }
    public void setAttachmentSizeMb(java.math.BigDecimal attachmentSizeMb) { this.attachmentSizeMb = attachmentSizeMb; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("chapterId", getChapterId())
            .append("courseId", getCourseId())
            .append("courseName", getCourseName())
            .append("chapterTitle", getChapterTitle())
            .append("chapterIntro", getChapterIntro())
            .append("orderNum", getOrderNum())
            .append("resourceCount", getResourceCount())
            .append("attachmentUrl", getAttachmentUrl())
            .append("attachmentName", getAttachmentName())
            .append("attachmentSizeMb", getAttachmentSizeMb())
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
