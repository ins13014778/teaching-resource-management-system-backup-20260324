package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduCourse;

public interface EduCourseMapper
{
    List<EduCourse> selectCourseList(EduCourse course);

    List<EduCourse> selectEnabledCourseList();

    EduCourse selectCourseById(Long courseId);

    EduCourse checkCourseNameUnique(String courseName);

    int insertCourse(EduCourse course);

    int updateCourse(EduCourse course);

    int deleteCourseByIds(Long[] courseIds);
}
