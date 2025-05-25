package com.qh.recruit.user.service.impl;

import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.JobRecommendQuery;

import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.mapper.RecommendInterviewMapper;
import com.qh.recruit.user.mapper.RecommendJobMapper;
import com.qh.recruit.user.mapper.RecommendResumeMapper;
import com.qh.recruit.user.mapper.UserJobMapper;
import com.qh.recruit.user.service.RecommendService;
import com.qh.recruit.user.util.strategy.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 职位推荐服务实现类
 */
@Service
public class RecommendServiceImpl implements RecommendService {

    @Autowired
    private UserJobMapper userJobMapper;

    @Resource
    private RecommendJobMapper recommendJobMapper;
    @Resource
    private RecommendInterviewMapper recommendInterviewMapper;
    @Autowired
    private RecommendResumeMapper recommendResumeMapper;

    @Autowired
    private RecommendServiceImpl recommendService;





    private RecommendStrategy recommendStrategy;



    /**
     * 计算技能匹配度得分
     */
    public double calculateSkillMatchScore(LoginUser user, UserJob job) {
        Long userId = user.getUserId();

        ResumeJob resume = recommendResumeMapper.selectResumeById(userId);
        int userSkills = recommendResumeMapper.selectResumeByJobIntention(resume.getJobIntention());

        int jobSkills = recommendJobMapper.selectByJobName(job.getName());
        // 获取用户技能列表
        long count = recommendInterviewMapper.matchCount(job.getId(), resume.getJobIntention());


        // 返回匹配度得分 (0-1之间)
        return (double) count / Math.max(userSkills, jobSkills);
    }

    /**
     * 计算热度匹配度得分
     */
    public double calculateHotMatchScore(LoginUser user, UserJob job) {
        //返回匹配度得分 (0-1之间)
        return (double) job.getPopularity()/100;
    }

    /**
     * 计算福利匹配度得分
     */
    public double calculateWelfareMatchScore(LoginUser user, UserJob job,int size) {
        long salaryDesc= Long.parseLong(job.getSalaryDesc());
        int count = recommendJobMapper.selectBySalary(salaryDesc);

        // 返回匹配度得分
        return (double) count / size;
    }


    /**
     * 获取推荐岗位列表
     * ①筛选
     * ②算法排序
     * @param query 查询条件
     * @param loginUser
     * @return
     */
    public AjaxResult getRecommendJobs(JobRecommendQuery query, LoginUser loginUser) {
        // 手动构造入参，获取岗位列表
        UserJobDto queryParam = new UserJobDto();
        if (query.getKeywords() != null && !query.getKeywords().isEmpty()) {
            queryParam.setKeywords(query.getKeywords());
        }
        if (query.getLocation() != null && !query.getLocation().isEmpty()) {
            queryParam.setLocation(query.getLocation());
        }
        if (query.getCategoryIds() != null && !query.getCategoryIds().isEmpty()) {
            queryParam.setCategoryIds(query.getCategoryIds());
        }
        if (query.getTagIds() != null && !query.getTagIds().isEmpty()) {
            queryParam.setTagIds(query.getTagIds());
        }
        if (query.getSalaryLowerBound() != null) {
            queryParam.setSalaryLowerBound(query.getSalaryLowerBound());
        }
        if (query.getSalaryUpperBound() != null) {
            queryParam.setSalaryUpperBound(query.getSalaryUpperBound());
        }
        List<UserJobDto> recommend = userJobMapper.selectJobList(queryParam);

        // 不同优先级排序
        String priority = query.getPriority();
        if (priority.equals("skill")) {
            recommendStrategy = new SkillsStrategy(recommendService);
            return recommendStrategy.recommend(loginUser, recommend);
        } else if (priority.equals("hot")) {
            recommendStrategy = new HotStrategy(recommendService);
            return recommendStrategy.recommend(loginUser,recommend);
        } else if (priority.equals("welfare")) {
            recommendStrategy = new WelfareStrategy(recommendService);
            return recommendStrategy.recommend(loginUser, recommend);
        }
        return AjaxResult.error("系统错误");
    }

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
        else if ("".equals(salary)){
            result[0]=0;
            result[1]=Integer.MAX_VALUE;
        }else {
            result[0]=15000;
            result[1]=Integer.MAX_VALUE;
        }
        return result;
    }

}