package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduMessage;

public interface EduMessageMapper
{
    List<EduMessage> selectMessageList(EduMessage message);

    EduMessage selectMessageById(Long messageId);

    int insertMessage(EduMessage message);

    int deleteMessageByIds(Long[] messageIds);

    int markRead(Long messageId);
}
