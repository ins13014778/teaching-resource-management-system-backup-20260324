package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduTeacherStudentGrant;

public interface EduTeacherStudentGrantMapper
{
    List<EduTeacherStudentGrant> selectGrantList(EduTeacherStudentGrant grant);

    EduTeacherStudentGrant selectGrantById(Long grantId);

    int insertGrant(EduTeacherStudentGrant grant);

    int updateGrant(EduTeacherStudentGrant grant);

    int deleteGrantByIds(Long[] grantIds);

    List<String> selectActiveCourseNamesByStudentId(@Param("studentUserId") Long studentUserId);

    List<EduTeacherStudentGrant> selectActiveGrantListByCourseName(@Param("courseName") String courseName);
}
