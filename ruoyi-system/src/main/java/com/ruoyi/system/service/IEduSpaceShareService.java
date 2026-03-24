package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduSpaceShare;

public interface IEduSpaceShareService
{
    List<EduSpaceShare> selectShareList(EduSpaceShare share);

    EduSpaceShare selectShareById(Long shareId);

    int insertShare(EduSpaceShare share);

    int updateShare(EduSpaceShare share);

    int deleteShareByIds(Long[] shareIds);
}
