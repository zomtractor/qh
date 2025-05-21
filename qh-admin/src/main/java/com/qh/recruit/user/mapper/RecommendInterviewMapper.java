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
public interface RecommendInterviewMapper {
    long matchCount(Long id, String jobIntention);

}
