package com.qh.recruit.user.util.strategy;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.JobScore;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.service.RecommendService;
import com.qh.recruit.user.service.impl.RecommendServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @auther xky
 * @date 2025/5/20
 * @describe
 */
@Component
public class SkillsStrategy  implements RecommendStrategy{
    private final RecommendServiceImpl recommendService;

    public SkillsStrategy(RecommendServiceImpl   recommendService) {
        this.recommendService = recommendService;
    }


    @Override
    public AjaxResult recommend(LoginUser loginUser,List<UserJobDto> userJobs) {

            int size = userJobs.size();
                // 计算职位得分并排序
                List<JobScore> jobScores = userJobs.stream().map(job -> {
                    JobScore score = new JobScore();
                    score.setUserJob(job);
                    // 基础匹配得分
                    double baseScore = 0.0;
                    // 根据优先条件计算权重
                            // 技能匹配度权重加倍
                            baseScore += recommendService.calculateSkillMatchScore(loginUser, job) * 2.0;
                            baseScore += recommendService.calculateHotMatchScore(loginUser, job);
                            baseScore += recommendService.calculateWelfareMatchScore(loginUser, job,size);
                    score.setScore(baseScore);
                    return score;
                }).sorted((a, b) -> Double.compare(b.getScore(), a.getScore())) // 按得分降序排序
                  .collect(Collectors.toList());
        return AjaxResult.success(jobScores);
    }
}
