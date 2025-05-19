package com.qh.recruit.user.controller;


import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.domain.JobRecommendQuery;
import com.qh.recruit.user.service.RecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 职位推荐控制器
 */
@RestController
@RequestMapping("/jobSeeker/recommend")
public class RecommendController  {

    @Autowired
    private RecommendService recommendService;

    /**
     * 获取推荐职位列表
     */
    @PostMapping("/list")
    public AjaxResult list(@RequestBody JobRecommendQuery query) {
        System.out.println(query);
        return recommendService.getRecommendJobs(query);
    }

    /**
     * 发起沟通
     */
    @PostMapping("/communicate/{jobId}")
    public AjaxResult communicate(@PathVariable("jobId") Long jobId) {
        return recommendService.communicate(jobId);
    }

    /**
     * 投递简历
     */
    @PostMapping("/submit/{jobId}")
    public AjaxResult submitResume(@PathVariable("jobId") Long jobId) {
        return recommendService.submitResume(jobId);
    }
}