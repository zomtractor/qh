package com.qh.recruit.user.util.strategy;

import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.user.domain.UserJob;

import java.util.List;

/**
 * @auther xky
 * @date 2025/5/20
 * @describe
 */
public interface RecommendStrategy {

    AjaxResult recommend(LoginUser loginUser,List<UserJob> userJobs);
}
