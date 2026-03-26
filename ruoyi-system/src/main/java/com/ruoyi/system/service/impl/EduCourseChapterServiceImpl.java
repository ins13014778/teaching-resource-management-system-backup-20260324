package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduCourse;
import com.ruoyi.system.domain.EduCourseChapter;
import com.ruoyi.system.mapper.EduCourseChapterMapper;
import com.ruoyi.system.mapper.EduCourseMapper;
import com.ruoyi.system.service.IEduCourseChapterService;

@Service
public class EduCourseChapterServiceImpl implements IEduCourseChapterService
{
    @Autowired
    private EduCourseChapterMapper chapterMapper;

    @Autowired
    private EduCourseMapper courseMapper;

    @Override
    public List<EduCourseChapter> selectChapterList(EduCourseChapter chapter)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            chapter.setCreateBy(String.valueOf(SecurityUtils.getUserId()));
        }
        return chapterMapper.selectChapterList(chapter);
    }

    @Override
    public EduCourseChapter selectChapterById(Long chapterId)
    {
        EduCourseChapter chapter = chapterMapper.selectChapterById(chapterId);
        checkPermission(chapter);
        return chapter;
    }

    @Override
    public int insertChapter(EduCourseChapter chapter)
    {
        fillCourseInfo(chapter);
        return chapterMapper.insertChapter(chapter);
    }

    @Override
    public int updateChapter(EduCourseChapter chapter)
    {
        checkPermission(chapterMapper.selectChapterById(chapter.getChapterId()));
        fillCourseInfo(chapter);
        return chapterMapper.updateChapter(chapter);
    }

    @Override
    public int deleteChapterByIds(Long[] chapterIds)
    {
        for (Long chapterId : chapterIds)
        {
            checkPermission(chapterMapper.selectChapterById(chapterId));
        }
        return chapterMapper.deleteChapterByIds(chapterIds);
    }

    private void fillCourseInfo(EduCourseChapter chapter)
    {
        if (chapter.getCourseId() == null)
        {
            throw new ServiceException("课程ID不能为空");
        }
        EduCourse course = courseMapper.selectCourseById(chapter.getCourseId());
        if (course == null)
        {
            throw new ServiceException("课程不存在");
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin() && !SecurityUtils.getUserId().equals(course.getTeacherUserId()))
        {
            throw new ServiceException("只能维护自己课程下的章节");
        }
        chapter.setCourseName(course.getCourseName());
        if (chapter.getOrderNum() == null)
        {
            chapter.setOrderNum(1);
        }
        if (chapter.getResourceCount() == null)
        {
            chapter.setResourceCount(0);
        }
        if (StringUtils.isEmpty(chapter.getStatus()))
        {
            chapter.setStatus("0");
        }
    }

    private void checkPermission(EduCourseChapter chapter)
    {
        if (chapter == null)
        {
            return;
        }
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            EduCourse course = courseMapper.selectCourseById(chapter.getCourseId());
            if (course != null && !SecurityUtils.getUserId().equals(course.getTeacherUserId()))
            {
                throw new ServiceException("只能操作自己课程下的章节");
            }
        }
    }
}