package com.ruoyi.web.controller.edu;

import java.util.List;
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
import com.ruoyi.system.domain.EduMessage;
import com.ruoyi.system.service.IEduMessageService;

@RestController
@RequestMapping("/edu/message")
public class EduMessageController extends BaseController
{
    @Autowired
    private IEduMessageService messageService;

    @PreAuthorize("@ss.hasPermi('edu:message:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduMessage message)
    {
        startPage();
        List<EduMessage> list = messageService.selectMessageList(message);
        return getDataTable(list);
    }

    @GetMapping("/my")
    public TableDataInfo my(EduMessage message)
    {
        startPage();
        List<EduMessage> list = messageService.selectMessageList(message);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('edu:message:query')")
    @GetMapping("/{messageId}")
    public AjaxResult getInfo(@PathVariable Long messageId)
    {
        return success(messageService.selectMessageById(messageId));
    }

    @PreAuthorize("@ss.hasPermi('edu:message:add')")
    @Log(title = "消息中心", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduMessage message)
    {
        message.setCreateBy(getUsername());
        return toAjax(messageService.insertMessage(message));
    }

    @PostMapping("/read/{messageId}")
    public AjaxResult read(@PathVariable Long messageId)
    {
        return toAjax(messageService.markRead(messageId));
    }

    @PreAuthorize("@ss.hasPermi('edu:message:remove')")
    @Log(title = "消息中心", businessType = BusinessType.DELETE)
    @DeleteMapping("/{messageIds}")
    public AjaxResult remove(@PathVariable Long[] messageIds)
    {
        return toAjax(messageService.deleteMessageByIds(messageIds));
    }
}
