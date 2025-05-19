package com.qh.recruit.user.service;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.JobRecommendQuery;

/**
 * 职位推荐服务接口
 */
public interface RecommendService {

    /**
     * 获取推荐职位列表
     *
     * @param query 查询条件
     * @return 职位列表
     */
    AjaxResult getRecommendJobs(JobRecommendQuery query);

    /**
     * 发起沟通
     *
     * @param jobId 职位ID
     * @return 操作结果
     */
    AjaxResult communicate(Long jobId);

    /**
     * 投递简历
     *
     * @param jobId 职位ID
     * @return 操作结果
     */
    AjaxResult submitResume(Long jobId);
}