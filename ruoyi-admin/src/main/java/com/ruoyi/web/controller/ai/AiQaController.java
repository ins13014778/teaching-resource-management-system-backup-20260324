package com.ruoyi.web.controller.ai;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiQaLog;
import com.ruoyi.system.service.IAiCapabilityService;
import com.ruoyi.system.service.IAiQaLogService;

@RestController
@RequestMapping("/ai/qa")
public class AiQaController extends BaseController
{
    @Autowired
    private IAiQaLogService qaLogService;

    @Autowired
    private IAiCapabilityService capabilityService;

    @PreAuthorize("@ss.hasPermi('ai:qa:list')")
    @GetMapping("/log/list")
    public TableDataInfo list(AiQaLog log)
    {
        startPage();
        List<AiQaLog> list = qaLogService.selectQaLogList(log);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:qa:ask')")
    @PostMapping("/ask")
    public AjaxResult ask(@RequestBody Map<String, String> body)
    {
        return success(capabilityService.ask(body.get("question")));
    }

    @PreAuthorize("@ss.hasPermi('ai:qa:remove')")
    @Log(title = "AI问答", businessType = BusinessType.DELETE)
    @DeleteMapping("/log/{qaIds}")
    public AjaxResult remove(@PathVariable Long[] qaIds)
    {
        return toAjax(qaLogService.deleteQaLogByIds(qaIds));
    }
}
