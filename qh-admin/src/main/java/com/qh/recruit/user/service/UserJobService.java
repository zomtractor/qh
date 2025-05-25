package com.qh.recruit.user.service;

import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.UserJob;

import java.util.List;

public interface UserJobService {

    public List<UserJob> getPageList(int pageNum,int pageSize);

    public int findTotal();

    public List<UserJob> getJobList(int pageSzie);

    public Integer searchJobCount(String keyword);

    public List<UserJob> getSearchJobList(String keyword,Integer pageNum,Integer pageSize);

    public Integer confirmCount(String location, String category, String salary);

    public List<UserJob> confirm(String location,String category,String salary,Integer pageNum,Integer pageSize);

    public Integer searchCategoryId(String category);

    public int[] salaryBeginAndEnd(String salary);
}