package com.qh.recruit.user.service;

import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.domain.ResumeJob;

public interface ResumeUserService {

    public AjaxResult getUserInfoByUserId(Long userId);

    public AjaxResult updateResumeInfo(ResumeJob resume);


    public AjaxResult getInterviewInfo(Interview interview);
}
