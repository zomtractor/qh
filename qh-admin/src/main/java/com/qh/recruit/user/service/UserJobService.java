package com.qh.recruit.user.service;

import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.UserJob;

import java.util.List;

public interface UserJobService {

    public List<UserJob> getPageList(int pageNum,int pageSize);

    public int findTotal();

    public List<UserJob> getJobList(int pageSzie);

    public List<UserJob> getSearchJobList(String keyword);

    public List<UserJob> confirm(String location,String category,String salary);

    public Integer searchCategoryId(String category);

    public int[] salaryBeginAndEnd(String salary);
}