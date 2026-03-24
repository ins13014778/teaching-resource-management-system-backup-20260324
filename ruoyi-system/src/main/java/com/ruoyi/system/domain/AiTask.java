package com.ruoyi.system.domain;

import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class AiTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long taskId;
    private String taskType;
    private Long resourceId;
    private String resourceTitle;
    private String triggerScene;
    private String taskStatus;
    private String resultJson;
    private String errorMsg;
    private Date startTime;
    private Date finishTime;

    public Long getTaskId() { return taskId; }
    public void setTaskId(Long taskId) { this.taskId = taskId; }
    public String getTaskType() { return taskType; }
    public void setTaskType(String taskType) { this.taskType = taskType; }
    public Long getResourceId() { return resourceId; }
    public void setResourceId(Long resourceId) { this.resourceId = resourceId; }
    public String getResourceTitle() { return resourceTitle; }
    public void setResourceTitle(String resourceTitle) { this.resourceTitle = resourceTitle; }
    public String getTriggerScene() { return triggerScene; }
    public void setTriggerScene(String triggerScene) { this.triggerScene = triggerScene; }
    public String getTaskStatus() { return taskStatus; }
    public void setTaskStatus(String taskStatus) { this.taskStatus = taskStatus; }
    public String getResultJson() { return resultJson; }
    public void setResultJson(String resultJson) { this.resultJson = resultJson; }
    public String getErrorMsg() { return errorMsg; }
    public void setErrorMsg(String errorMsg) { this.errorMsg = errorMsg; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }
    public Date getFinishTime() { return finishTime; }
    public void setFinishTime(Date finishTime) { this.finishTime = finishTime; }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("taskId", getTaskId())
            .append("taskType", getTaskType())
            .append("resourceId", getResourceId())
            .append("resourceTitle", getResourceTitle())
            .append("triggerScene", getTriggerScene())
            .append("taskStatus", getTaskStatus())
            .append("resultJson", getResultJson())
            .append("errorMsg", getErrorMsg())
            .append("startTime", getStartTime())
            .append("finishTime", getFinishTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
