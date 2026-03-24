package com.ruoyi.system.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.EduFavorite;
import com.ruoyi.system.domain.EduResource;
import com.ruoyi.system.mapper.EduFavoriteMapper;
import com.ruoyi.system.mapper.EduResourceMapper;
import com.ruoyi.system.service.IEduFavoriteService;

@Service
public class EduFavoriteServiceImpl implements IEduFavoriteService
{
    @Autowired
    private EduFavoriteMapper favoriteMapper;

    @Autowired
    private EduResourceMapper resourceMapper;

    @Override
    public List<EduFavorite> selectFavoriteList(EduFavorite favorite)
    {
        if (!SecurityUtils.isAdmin())
        {
            favorite.setUserId(SecurityUtils.getUserId());
        }
        return favoriteMapper.selectFavoriteList(favorite);
    }

    @Override
    public EduFavorite selectFavoriteById(Long favoriteId)
    {
        return favoriteMapper.selectFavoriteById(favoriteId);
    }

    @Override
    public int insertFavorite(EduFavorite favorite)
    {
        return favoriteMapper.insertFavorite(favorite);
    }

    @Override
    public int deleteFavoriteByIds(Long[] favoriteIds)
    {
        return favoriteMapper.deleteFavoriteByIds(favoriteIds);
    }

    @Override
    @Transactional
    public Map<String, Object> toggleFavorite(Long resourceId)
    {
        EduResource resource = resourceMapper.selectResourceById(resourceId);
        if (resource == null)
        {
            throw new ServiceException("资源不存在");
        }
        Long userId = SecurityUtils.getUserId();
        EduFavorite db = favoriteMapper.selectByUserIdAndResourceId(userId, resourceId);
        Map<String, Object> result = new LinkedHashMap<>();
        if (db != null)
        {
            favoriteMapper.deleteById(db.getFavoriteId());
            resourceMapper.changeFavoriteCount(resourceId, -1);
            result.put("favorited", false);
            result.put("message", "已取消收藏");
            return result;
        }
        EduFavorite favorite = new EduFavorite();
        favorite.setResourceId(resourceId);
        favorite.setResourceTitle(resource.getResourceTitle());
        favorite.setUserId(userId);
        favorite.setUserName(SecurityUtils.getUsername());
        favorite.setCreateBy(SecurityUtils.getUsername());
        favoriteMapper.insertFavorite(favorite);
        resourceMapper.changeFavoriteCount(resourceId, 1);
        result.put("favorited", true);
        result.put("message", "收藏成功");
        return result;
    }
}
