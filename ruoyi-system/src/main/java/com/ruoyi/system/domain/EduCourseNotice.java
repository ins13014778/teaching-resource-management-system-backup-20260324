package com.ruoyi.system.domain;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduCourseNotice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long noticeId;
    private Long courseId;
    private String courseName;
    private String noticeTitle;
    private String noticeContent;
    private Long publisherId;
    private String publisherName;
    private String status;
    private String delFlag;
    private List<String> courseNameScope;

    public Long getNoticeId() { return noticeId; }
    public void setNoticeId(Long noticeId) { this.noticeId = noticeId; }
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getNoticeTitle() { return noticeTitle; }
    public void setNoticeTitle(String noticeTitle) { this.noticeTitle = noticeTitle; }
    public String getNoticeContent() { return noticeContent; }
    public void setNoticeContent(String noticeContent) { this.noticeContent = noticeContent; }
    public Long getPublisherId() { return publisherId; }
    public void setPublisherId(Long publisherId) { this.publisherId = publisherId; }
    public String getPublisherName() { return publisherName; }
    public void setPublisherName(String publisherName) { this.publisherName = publisherName; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public List<String> getCourseNameScope() { return courseNameScope; }
    public void setCourseNameScope(List<String> courseNameScope) { this.courseNameScope = courseNameScope; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("noticeId", getNoticeId())
            .append("courseId", getCourseId())
            .append("courseName", getCourseName())
            .append("noticeTitle", getNoticeTitle())
            .append("noticeContent", getNoticeContent())
            .append("publisherId", getPublisherId())
            .append("publisherName", getPublisherName())
            .append("status", getStatus())
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
