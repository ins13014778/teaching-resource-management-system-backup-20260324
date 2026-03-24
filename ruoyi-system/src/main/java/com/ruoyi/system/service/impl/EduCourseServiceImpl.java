package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.EduCourse;
import com.ruoyi.system.mapper.EduCourseMapper;
import com.ruoyi.system.mapper.EduTeacherStudentGrantMapper;
import com.ruoyi.system.service.IEduCourseService;

@Service
public class EduCourseServiceImpl implements IEduCourseService
{
    @Autowired
    private EduCourseMapper courseMapper;

    @Autowired
    private EduTeacherStudentGrantMapper grantMapper;

    @Override
    public List<EduCourse> selectCourseList(EduCourse course)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            course.setTeacherUserId(SecurityUtils.getUserId());
        }
        if (SecurityUtils.hasRole("student") && !SecurityUtils.isAdmin())
        {
            course.setStatus("0");
            List<String> courseNames = grantMapper.selectActiveCourseNamesByStudentId(SecurityUtils.getUserId());
            if (!courseNames.isEmpty())
            {
                course.setCourseNameScope(courseNames);
            }
        }
        return courseMapper.selectCourseList(course);
    }

    @Override
    public List<EduCourse> selectEnabledCourseList()
    {
        return courseMapper.selectEnabledCourseList();
    }

    @Override
    public EduCourse selectCourseById(Long courseId)
    {
        return courseMapper.selectCourseById(courseId);
    }

    @Override
    public boolean checkCourseNameUnique(EduCourse course)
    {
        Long courseId = StringUtils.isNull(course.getCourseId()) ? -1L : course.getCourseId();
        EduCourse info = courseMapper.checkCourseNameUnique(course.getCourseName());
        return StringUtils.isNull(info) || info.getCourseId().longValue() == courseId.longValue();
    }

    @Override
    public int insertCourse(EduCourse course)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            course.setTeacherUserId(SecurityUtils.getUserId());
            if (StringUtils.isEmpty(course.getTeacherName()))
            {
                course.setTeacherName(SecurityUtils.getUsername());
            }
        }
        return courseMapper.insertCourse(course);
    }

    @Override
    public int updateCourse(EduCourse course)
    {
        if (SecurityUtils.hasRole("teacher") && !SecurityUtils.isAdmin())
        {
            course.setTeacherUserId(SecurityUtils.getUserId());
            if (StringUtils.isEmpty(course.getTeacherName()))
            {
                course.setTeacherName(SecurityUtils.getUsername());
            }
        }
        return courseMapper.updateCourse(course);
    }

    @Override
    public int deleteCourseByIds(Long[] courseIds)
    {
        return courseMapper.deleteCourseByIds(courseIds);
    }
}
