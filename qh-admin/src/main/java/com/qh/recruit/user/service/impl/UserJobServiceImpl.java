package com.qh.recruit.user.service.impl;

import com.qh.recruit.admin.domain.Category;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Tag;
import com.qh.recruit.admin.mapper.CategoryMapper;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.mapper.TagMapper;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.mapper.UserJobMapper;
import com.qh.recruit.user.service.UserJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class UserJobServiceImpl implements UserJobService {

    @Autowired
    private UserJobMapper jobMapper;

    @Resource
    private EtpMapper etpMapper;

    @Resource
    private TagMapper tagMapper;

    @Resource
    private CategoryMapper categoryMapper;

    @Override
    public UserJob selectJobById(Long id) {
        UserJobDto job = (UserJobDto) jobMapper.selectJobById(id);
        loadTagsAndCategories(job);
        return job;
    }

    @Override
    public List<UserJobDto> getJobList(UserJobDto job) {
        List<UserJobDto> jobList = jobMapper.selectJobList(job);
        for (UserJobDto uj : jobList) {
            loadTagsAndCategories(uj);
        }
        return jobList;
    }

    private void loadTagsAndCategories(UserJobDto job) {
        Etp etp = etpMapper.selectEtpById(job.getEtpId());
        job.setEtpName(etp.getName());List<Tag> tagList= tagMapper.selectTagsByIds(job.getTagIds());
        job.setTagList(tagList);
        List<Category> categoryList = categoryMapper.selectCategoryByIds(job.getCategoryIds());
        job.setCategoryList(categoryList);
    }

    @Autowired
    UserJobService userJobService;

    @Override
    public List<UserJob> getPageList(int pageNum, int pageSize) {
        return jobMapper.getPageList(pageNum,pageSize);
    }

    @Override
    public int findTotal() {
        return jobMapper.findTotal();
    }

    @Override
    public List<UserJob> getJobList(int pageSize) {
        List<UserJob> jobList = jobMapper.selectJobList(pageSize);
        return jobList;
    }

    @Override
    public Integer searchJobCount(String keyword) {
        return jobMapper.searchJobCount(keyword);
    }

    @Override
    public List<UserJob> getSearchJobList(String keyword,Integer pageNum,Integer pageSize) {
        List<UserJob> jobs = jobMapper.searchJobList(keyword,pageNum,pageSize);
        return jobs;
    }

    @Override
    public Integer confirmCount(String location, String category, String salary) {
        Integer Id = userJobService.searchCategoryId(category);
        int[] result=userJobService.salaryBeginAndEnd(salary);
        String categoryId=String.valueOf(Id);
        return jobMapper.confirmCount(location,categoryId,result[0], result[1]);
    }

    @Override
    public List<UserJob> confirm(String location, String category, String salary,Integer pageNum,Integer pageSize) {
        Integer Id = userJobService.searchCategoryId(category);
        int[] result=userJobService.salaryBeginAndEnd(salary);
        String categoryId=String.valueOf(Id);
        List<UserJob> jobs = jobMapper.confirm(location, categoryId, result[0], result[1],pageNum,pageSize);
        return jobs;
    }

    @Override
    public Integer searchCategoryId(String category) {
        return jobMapper.searchCategoryId(category);
    }

    @Override
    public int[] salaryBeginAndEnd(String salary){
        int[] result=new int[2];
        if("5k以下".equals(salary)){
            result[0]=0;
            result[1]=4999;
        }
        else if("5-10k".equals(salary)){
            result[0]=5000;
            result[1]=9999;
        }
        else if("10-15k".equals(salary)){
            result[0]=10000;
            result[1]=14999;
        }
        else if (salary.isEmpty()){
            result[0]=0;
            result[1]=Integer.MAX_VALUE;
        }else {
            result[0]=15000;
            result[1]=Integer.MAX_VALUE;
        }
        return result;
    }
}