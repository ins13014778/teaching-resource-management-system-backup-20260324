package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.mapper.AiTaskMapper;
import com.ruoyi.system.service.IAiTaskService;

@Service
public class AiTaskServiceImpl implements IAiTaskService
{
    @Autowired
    private AiTaskMapper taskMapper;

    @Override
    public List<AiTask> selectTaskList(AiTask task)
    {
        return taskMapper.selectTaskList(task);
    }

    @Override
    public AiTask selectTaskById(Long taskId)
    {
        return taskMapper.selectTaskById(taskId);
    }

    @Override
    public int insertTask(AiTask task)
    {
        return taskMapper.insertTask(task);
    }

    @Override
    public int deleteTaskByIds(Long[] taskIds)
    {
        return taskMapper.deleteTaskByIds(taskIds);
    }
}
