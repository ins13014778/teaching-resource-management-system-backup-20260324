package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AiTask;

public interface AiTaskMapper
{
    List<AiTask> selectTaskList(AiTask task);

    AiTask selectTaskById(Long taskId);

    int insertTask(AiTask task);

    int deleteTaskByIds(Long[] taskIds);
}
