package com.ruoyi.system.mapper;

import java.math.BigDecimal;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.EduSpaceFile;

public interface EduSpaceFileMapper
{
    List<EduSpaceFile> selectSpaceFileList(EduSpaceFile spaceFile);

    EduSpaceFile selectSpaceFileById(Long fileId);

    int insertSpaceFile(EduSpaceFile spaceFile);

    int updateSpaceFile(EduSpaceFile spaceFile);

    int deleteSpaceFileByIds(Long[] fileIds);

    BigDecimal sumFileSizeByIds(@Param("fileIds") Long[] fileIds);
}