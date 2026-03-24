package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.EduSpaceShare;
import com.ruoyi.system.mapper.EduSpaceShareMapper;
import com.ruoyi.system.service.IEduSpaceShareService;

@Service
public class EduSpaceShareServiceImpl implements IEduSpaceShareService
{
    @Autowired
    private EduSpaceShareMapper shareMapper;

    @Override
    public List<EduSpaceShare> selectShareList(EduSpaceShare share)
    {
        return shareMapper.selectShareList(share);
    }

    @Override
    public EduSpaceShare selectShareById(Long shareId)
    {
        return shareMapper.selectShareById(shareId);
    }

    @Override
    public int insertShare(EduSpaceShare share)
    {
        return shareMapper.insertShare(share);
    }

    @Override
    public int updateShare(EduSpaceShare share)
    {
        return shareMapper.updateShare(share);
    }

    @Override
    public int deleteShareByIds(Long[] shareIds)
    {
        return shareMapper.deleteShareByIds(shareIds);
    }
}
