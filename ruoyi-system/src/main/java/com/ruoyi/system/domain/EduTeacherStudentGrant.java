package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduTeacherStudentGrant extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long grantId;
    private Long teacherUserId;
    private String teacherName;
    private Long studentUserId;
    private String studentName;
    private String courseName;
    private String grantPreset;
    private String grantPerms;
    private String status;
    private Date expiresAt;

    public Long getGrantId()
    {
        return grantId;
    }

    public void setGrantId(Long grantId)
    {
        this.grantId = grantId;
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

    public Long getStudentUserId()
    {
        return studentUserId;
    }

    public void setStudentUserId(Long studentUserId)
    {
        this.studentUserId = studentUserId;
    }

    public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public void setCourseName(String courseName)
    {
        this.courseName = courseName;
    }

    public String getGrantPreset()
    {
        return grantPreset;
    }

    public void setGrantPreset(String grantPreset)
    {
        this.grantPreset = grantPreset;
    }

    public String getGrantPerms()
    {
        return grantPerms;
    }

    public void setGrantPerms(String grantPerms)
    {
        this.grantPerms = grantPerms;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Date getExpiresAt()
    {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt)
    {
        this.expiresAt = expiresAt;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("grantId", getGrantId())
            .append("teacherUserId", getTeacherUserId())
            .append("teacherName", getTeacherName())
            .append("studentUserId", getStudentUserId())
            .append("studentName", getStudentName())
            .append("courseName", getCourseName())
            .append("grantPreset", getGrantPreset())
            .append("grantPerms", getGrantPerms())
            .append("status", getStatus())
            .append("expiresAt", getExpiresAt())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
