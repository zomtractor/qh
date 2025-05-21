package com.qh.recruit.user.domain;

import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.dto.JobDto;
import lombok.Data;

/**
 * 职位得分实体类
 * 用于存储职位匹配得分信息
 */
@Data
public class JobScore {
    
    /**
     * 职位信息
     */
    private UserJob UserJob;
    
    /**
     * 匹配得分
     */
    private double score;

    private Integer total;
}