package com.qh.recruit.user.controller;


import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.framework.web.service.TokenService;
import com.qh.recruit.user.domain.JobRecommendQuery;
import com.qh.recruit.user.service.RecommendService;
import com.qh.recruit.user.util.UserHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * 职位推荐控制器
 */
@RestController
@RequestMapping("/jobSeeker")
public class RecommendController  {

    @Autowired
    private RecommendService recommendService;


    /**
     * 获取推荐职位列表
     */
    @GetMapping("/recommend/list")
    public AjaxResult list(JobRecommendQuery query) {
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(UserHolder.getUser().getId());
        return recommendService.getRecommendJobs(query,loginUser);
    }


}