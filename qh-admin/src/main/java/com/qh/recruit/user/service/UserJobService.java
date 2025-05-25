package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.UserJob;

import java.util.List;

public interface UserJobService {

    /**
     * 查询岗位
     *
     * @param id 岗位主键
     * @return 岗位
     */
    public UserJob selectJobById(Long id);

    /**
     * 查询岗位列表
     *
     * @param job 岗位
     * @return 岗位
     */
    public List<UserJobDto> getJobList(UserJobDto job);

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