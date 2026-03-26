package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.EduSpaceFile;

public interface IEduSpaceFileService
{
    List<EduSpaceFile> selectSpaceFileList(EduSpaceFile spaceFile);

    EduSpaceFile selectSpaceFileById(Long fileId);

    int insertSpaceFile(EduSpaceFile spaceFile);

    int updateSpaceFile(EduSpaceFile spaceFile);

    int deleteSpaceFileByIds(Long[] fileIds);
}