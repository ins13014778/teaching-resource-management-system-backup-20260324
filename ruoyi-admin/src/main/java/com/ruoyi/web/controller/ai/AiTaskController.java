package com.ruoyi.web.controller.ai;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.service.IAiCapabilityService;
import com.ruoyi.system.service.IAiTaskService;

@RestController
@RequestMapping("/ai/task")
public class AiTaskController extends BaseController
{
    @Autowired
    private IAiTaskService taskService;

    @Autowired
    private IAiCapabilityService capabilityService;

    @PreAuthorize("@ss.hasPermi('ai:task:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiTask task)
    {
        startPage();
        List<AiTask> list = taskService.selectTaskList(task);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:task:query')")
    @GetMapping("/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        return success(taskService.selectTaskById(taskId));
    }

    @PreAuthorize("@ss.hasPermi('ai:task:run')")
    @Log(title = "AI任务", businessType = BusinessType.INSERT)
    @PostMapping("/run/{resourceId}")
    public AjaxResult run(@PathVariable Long resourceId)
    {
        capabilityService.runAutoTasks(resourceId, "manual");
        return success();
    }

    @PreAuthorize("@ss.hasPermi('ai:task:remove')")
    @Log(title = "AI任务", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(taskService.deleteTaskByIds(taskIds));
    }
}
