package com.qh.recruit.user.domain;

import lombok.Data;

/**
 * 职位推荐查询参数
 */
@Data
public class JobRecommendQuery {


    /**
     * 工作城市
     */
    private String city;

    /**
     * 期望薪资
     */
    private String salary;

    /**
     * 公司行业
     */
    private String industry;

    /**
     * 优先技能
     */
    private String priority;

    /**
     * 当前页码
     */
    private Integer page;

    /**
     * 每页数量
     */
    private Integer pageSize;



}