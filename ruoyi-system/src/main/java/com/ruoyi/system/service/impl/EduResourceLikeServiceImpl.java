package com.ruoyi.system.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.domain.EduResourceLike;
import com.ruoyi.system.mapper.EduResourceLikeMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.service.IEduResourceLikeService;

@Service
public class EduResourceLikeServiceImpl implements IEduResourceLikeService
{
    @Autowired
    private EduResourceLikeMapper likeMapper;

    @Autowired
    private EduResourceMapper resourceMapper;

    @Override
    public List<EduResourceLike> selectLikeList(EduResourceLike like)
    {
        if (!SecurityUtils.isAdmin())
        {
            like.setUserId(SecurityUtils.getUserId());
        }
        return likeMapper.selectLikeList(like);
    }

    @Override
    public EduResourceLike selectLikeById(Long likeId)
    {
        return likeMapper.selectLikeById(likeId);
    }

    @Override
    @Transactional
    public Map<String, Object> toggleLike(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        Long userId = SecurityUtils.getUserId();
        EduResourceLike db = likeMapper.selectByUserIdAndResourceId(userId, resourceId);
        Map<String, Object> result = new LinkedHashMap<>();
        if (db != null)
        {
            likeMapper.deleteById(db.getLikeId());
            resourceMapper.changeLikeCount(resourceId, -1);
            result.put("liked", false);
            result.put("message", "已取消点赞");
            return result;
        }
        EduResourceLike like = new EduResourceLike();
        like.setResourceId(resourceId);
        like.setResourceTitle(resource.getResourceTitle());
        like.setUserId(userId);
        like.setUserName(SecurityUtils.getUsername());
        like.setCreateBy(SecurityUtils.getUsername());
        likeMapper.insertLike(like);
        resourceMapper.changeLikeCount(resourceId, 1);
        result.put("liked", true);
        result.put("message", "点赞成功");
        return result;
    }

    @Override
    public int deleteLikeByIds(Long[] likeIds)
    {
        return likeMapper.deleteLikeByIds(likeIds);
    }
}
