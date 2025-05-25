package com.qh.recruit.user.domain;

import lombok.Data;

/**
 * 职位推荐查询参数
 */
@Data
public class JobRecommendQuery {

    private String priority;
    private String keywords;
    private String location;
    private Integer salaryLowerBound;
    private Integer salaryUpperBound;
    private String categoryIds;
    private String tagIds;

    // TODO:暂时无用
    private Integer page;
    private Integer pageSize;
}