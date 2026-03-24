package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class EduGlobalConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long configId;
    private Integer globalUploadMb;
    private Integer videoUploadMb;
    private Integer designUploadMb;
    private Integer teacherDefaultStorageGb;
    private Integer teacherDefaultUploadMb;
    private Integer studentDefaultStorageGb;
    private Integer studentDefaultUploadMb;
    private Integer shareDefaultDays;
    private Integer shareMaxDays;
    private String passwordShareEnable;
    private String teacherShareEnable;
    private String studentShareEnable;
    private Integer recycleKeepDays;
    private Integer storageWarnPercent;

    public Long getConfigId()
    {
        return configId;
    }

    public void setConfigId(Long configId)
    {
        this.configId = configId;
    }

    public Integer getGlobalUploadMb()
    {
        return globalUploadMb;
    }

    public void setGlobalUploadMb(Integer globalUploadMb)
    {
        this.globalUploadMb = globalUploadMb;
    }

    public Integer getVideoUploadMb()
    {
        return videoUploadMb;
    }

    public void setVideoUploadMb(Integer videoUploadMb)
    {
        this.videoUploadMb = videoUploadMb;
    }

    public Integer getDesignUploadMb()
    {
        return designUploadMb;
    }

    public void setDesignUploadMb(Integer designUploadMb)
    {
        this.designUploadMb = designUploadMb;
    }

    public Integer getTeacherDefaultStorageGb()
    {
        return teacherDefaultStorageGb;
    }

    public void setTeacherDefaultStorageGb(Integer teacherDefaultStorageGb)
    {
        this.teacherDefaultStorageGb = teacherDefaultStorageGb;
    }

    public Integer getTeacherDefaultUploadMb()
    {
        return teacherDefaultUploadMb;
    }

    public void setTeacherDefaultUploadMb(Integer teacherDefaultUploadMb)
    {
        this.teacherDefaultUploadMb = teacherDefaultUploadMb;
    }

    public Integer getStudentDefaultStorageGb()
    {
        return studentDefaultStorageGb;
    }

    public void setStudentDefaultStorageGb(Integer studentDefaultStorageGb)
    {
        this.studentDefaultStorageGb = studentDefaultStorageGb;
    }

    public Integer getStudentDefaultUploadMb()
    {
        return studentDefaultUploadMb;
    }

    public void setStudentDefaultUploadMb(Integer studentDefaultUploadMb)
    {
        this.studentDefaultUploadMb = studentDefaultUploadMb;
    }

    public Integer getShareDefaultDays()
    {
        return shareDefaultDays;
    }

    public void setShareDefaultDays(Integer shareDefaultDays)
    {
        this.shareDefaultDays = shareDefaultDays;
    }

    public Integer getShareMaxDays()
    {
        return shareMaxDays;
    }

    public void setShareMaxDays(Integer shareMaxDays)
    {
        this.shareMaxDays = shareMaxDays;
    }

    public String getPasswordShareEnable()
    {
        return passwordShareEnable;
    }

    public void setPasswordShareEnable(String passwordShareEnable)
    {
        this.passwordShareEnable = passwordShareEnable;
    }

    public String getTeacherShareEnable()
    {
        return teacherShareEnable;
    }

    public void setTeacherShareEnable(String teacherShareEnable)
    {
        this.teacherShareEnable = teacherShareEnable;
    }

    public String getStudentShareEnable()
    {
        return studentShareEnable;
    }

    public void setStudentShareEnable(String studentShareEnable)
    {
        this.studentShareEnable = studentShareEnable;
    }

    public Integer getRecycleKeepDays()
    {
        return recycleKeepDays;
    }

    public void setRecycleKeepDays(Integer recycleKeepDays)
    {
        this.recycleKeepDays = recycleKeepDays;
    }

    public Integer getStorageWarnPercent()
    {
        return storageWarnPercent;
    }

    public void setStorageWarnPercent(Integer storageWarnPercent)
    {
        this.storageWarnPercent = storageWarnPercent;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("configId", getConfigId())
            .append("globalUploadMb", getGlobalUploadMb())
            .append("videoUploadMb", getVideoUploadMb())
            .append("designUploadMb", getDesignUploadMb())
            .append("teacherDefaultStorageGb", getTeacherDefaultStorageGb())
            .append("teacherDefaultUploadMb", getTeacherDefaultUploadMb())
            .append("studentDefaultStorageGb", getStudentDefaultStorageGb())
            .append("studentDefaultUploadMb", getStudentDefaultUploadMb())
            .append("shareDefaultDays", getShareDefaultDays())
            .append("shareMaxDays", getShareMaxDays())
            .append("passwordShareEnable", getPasswordShareEnable())
            .append("teacherShareEnable", getTeacherShareEnable())
            .append("studentShareEnable", getStudentShareEnable())
            .append("recycleKeepDays", getRecycleKeepDays())
            .append("storageWarnPercent", getStorageWarnPercent())
            .append("remark", getRemark())
            .toString();
    }
}
