package com.qh.recruit.user.mapper;

import com.qh.recruit.user.domain.UserJob;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserJobMapper {

    public Integer searchJobCount(String keyword);

    public List<UserJob> getPageList(int pageNum,int pageSize);

    public int findTotal();

    public List<UserJob> selectJobList(int pageSize);

    public List<UserJob> searchJobList(String keyword,Integer pageNum,Integer pageSize);

    public Integer searchCategoryId(String category);

    public Integer confirmCount(String location, String categoryId, Integer begin, Integer end);

    public List<UserJob> confirm(String location, String categoryId, Integer begin, Integer end,Integer pageNum,Integer pageSize);
    public List<UserJob> confirms(String location, String categoryId, Integer begin, Integer end);
    public List<UserJob> selectJoball();
}