package com.ruoyi.system.domain;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long courseId;

    private String courseName;

    private String courseCode;

    private Long teacherUserId;

    private String teacherName;

    private String courseIntro;

    private String status;

    private String delFlag;

    private List<String> courseNameScope;

    public Long getCourseId()
    {
        return courseId;
    }

    public void setCourseId(Long courseId)
    {
        this.courseId = courseId;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public void setCourseName(String courseName)
    {
        this.courseName = courseName;
    }

    public String getCourseCode()
    {
        return courseCode;
    }

    public void setCourseCode(String courseCode)
    {
        this.courseCode = courseCode;
    }

    public Long getTeacherUserId()
    {
        return teacherUserId;
    }

    public void setTeacherUserId(Long teacherUserId)
    {
        this.teacherUserId = teacherUserId;
    }

    public String getTeacherName()
    {
        return teacherName;
    }

    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }

    public String getCourseIntro()
    {
        return courseIntro;
    }

    public void setCourseIntro(String courseIntro)
    {
        this.courseIntro = courseIntro;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
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
            .append("courseId", getCourseId())
            .append("courseName", getCourseName())
            .append("courseCode", getCourseCode())
            .append("teacherUserId", getTeacherUserId())
            .append("teacherName", getTeacherName())
            .append("courseIntro", getCourseIntro())
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
