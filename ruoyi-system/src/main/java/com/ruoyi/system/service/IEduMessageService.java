package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduMessage;

public interface IEduMessageService
{
    List<EduMessage> selectMessageList(EduMessage message);

    EduMessage selectMessageById(Long messageId);

    int insertMessage(EduMessage message);

    int deleteMessageByIds(Long[] messageIds);

    int markRead(Long messageId);

    int sendMessage(Long userId, String userName, String title, String content, String messageType, Long bizId);
}
