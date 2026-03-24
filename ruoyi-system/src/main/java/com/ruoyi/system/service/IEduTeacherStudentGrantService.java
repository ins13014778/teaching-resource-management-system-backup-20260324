package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduTeacherStudentGrant;

public interface IEduTeacherStudentGrantService
{
    List<EduTeacherStudentGrant> selectGrantList(EduTeacherStudentGrant grant);

    EduTeacherStudentGrant selectGrantById(Long grantId);

    int insertGrant(EduTeacherStudentGrant grant);

    int updateGrant(EduTeacherStudentGrant grant);

    int deleteGrantByIds(Long[] grantIds);
}
