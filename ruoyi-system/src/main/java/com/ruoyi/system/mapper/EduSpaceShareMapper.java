package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduSpaceShare;

public interface EduSpaceShareMapper
{
    List<EduSpaceShare> selectShareList(EduSpaceShare share);

    EduSpaceShare selectShareById(Long shareId);

    int insertShare(EduSpaceShare share);

    int updateShare(EduSpaceShare share);

    int deleteShareByIds(Long[] shareIds);
}
