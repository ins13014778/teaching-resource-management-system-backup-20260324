package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduResourceLike;

public interface EduResourceLikeMapper
{
    List<EduResourceLike> selectLikeList(EduResourceLike like);

    EduResourceLike selectLikeById(Long likeId);

    EduResourceLike selectByUserIdAndResourceId(Long userId, Long resourceId);

    int insertLike(EduResourceLike like);

    int deleteLikeByIds(Long[] likeIds);

    int deleteById(Long likeId);
}
