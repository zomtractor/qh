package com.qh.recruit.user.mapper;

import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.UserJob;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserJobMapper {
    public List<UserJob> selectJobList();

    public List<UserJob> searchJobList(String keyword);

    public Integer searchCategoryId(String category);

    public List<UserJob> confirm(String location, String categoryId, Integer begin, Integer end);
}