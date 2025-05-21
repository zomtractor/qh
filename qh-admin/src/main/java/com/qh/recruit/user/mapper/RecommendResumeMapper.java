package com.qh.recruit.user.mapper;

import com.qh.recruit.user.domain.ResumeJob;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @auther xky
 * @date 2025/5/21
 * @describe
 */
@Mapper
@Repository
public interface RecommendResumeMapper {
    public ResumeJob selectResumeById(Long userId);

    public int selectResumeByJobIntention(String jobIntention);
}
