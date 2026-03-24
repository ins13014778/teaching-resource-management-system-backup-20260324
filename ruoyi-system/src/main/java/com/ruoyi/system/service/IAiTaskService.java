package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.AiTask;

public interface IAiTaskService
{
    List<AiTask> selectTaskList(AiTask task);

    AiTask selectTaskById(Long taskId);

    int insertTask(AiTask task);

    int deleteTaskByIds(Long[] taskIds);
}
