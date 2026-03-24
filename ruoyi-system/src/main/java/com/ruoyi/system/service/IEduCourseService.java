package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduCourse;

public interface IEduCourseService
{
    List<EduCourse> selectCourseList(EduCourse course);

    List<EduCourse> selectEnabledCourseList();

    EduCourse selectCourseById(Long courseId);

    boolean checkCourseNameUnique(EduCourse course);

    int insertCourse(EduCourse course);

    int updateCourse(EduCourse course);

    int deleteCourseByIds(Long[] courseIds);
}
