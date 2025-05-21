package com.qh.recruit.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @auther xky
 * @date 2025/5/21
 * @describe
 */
@Mapper
@Repository
public interface RecommendJobMapper {
    /**
     * 根据工作名查询数量
     * @param name
     * @return
     */
    int selectByJobName(String name);

    /**
     * 获取相对福利低的数量
     * @param salaryDesc
     * @return
     */
    int selectBySalary(long salaryDesc);
}
