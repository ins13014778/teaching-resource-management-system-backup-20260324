package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduMessage;
import com.ruoyi.system.mapper.EduMessageMapper;
import com.ruoyi.system.service.IEduMessageService;

@Service
public class EduMessageServiceImpl implements IEduMessageService
{
    @Autowired
    private EduMessageMapper messageMapper;

    @Override
    public List<EduMessage> selectMessageList(EduMessage message)
    {
        if (!SecurityUtils.isAdmin())
        {
            message.setUserId(SecurityUtils.getUserId());
        }
        return messageMapper.selectMessageList(message);
    }

    @Override
    public EduMessage selectMessageById(Long messageId)
    {
        EduMessage message = messageMapper.selectMessageById(messageId);
        if (message != null && !SecurityUtils.isAdmin() && !SecurityUtils.getUserId().equals(message.getUserId()))
        {
            throw new ServiceException("无权查看该消息");
        }
        return message;
    }

    @Override
    public int insertMessage(EduMessage message)
    {
        if (StringUtils.isEmpty(message.getReadStatus()))
        {
            message.setReadStatus("0");
        }
        if (StringUtils.isEmpty(message.getMessageType()))
        {
            message.setMessageType("system");
        }
        return messageMapper.insertMessage(message);
    }

    @Override
    public int deleteMessageByIds(Long[] messageIds)
    {
        return messageMapper.deleteMessageByIds(messageIds);
    }

    @Override
    public int markRead(Long messageId)
    {
        EduMessage db = messageMapper.selectMessageById(messageId);
        if (db == null)
        {
            throw new ServiceException("消息不存在");
        }
        if (!SecurityUtils.isAdmin() && !SecurityUtils.getUserId().equals(db.getUserId()))
        {
            throw new ServiceException("无权操作该消息");
        }
        return messageMapper.markRead(messageId);
    }

    @Override
    public int sendMessage(Long userId, String userName, String title, String content, String messageType, Long bizId)
    {
        EduMessage message = new EduMessage();
        message.setUserId(userId);
        message.setUserName(userName);
        message.setMessageTitle(title);
        message.setMessageContent(content);
        message.setMessageType(messageType);
        message.setBizId(bizId);
        message.setReadStatus("0");
        message.setCreateBy(SecurityUtils.getUsername());
        return messageMapper.insertMessage(message);
    }
}
