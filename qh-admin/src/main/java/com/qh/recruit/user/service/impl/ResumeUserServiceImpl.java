package com.qh.recruit.user.service.impl;


import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.domain.dto.InterviewDto;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.utils.DateUtils;
import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.mapper.ResumeUserMapper;

import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.qh.recruit.user.service.ResumeUserService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class ResumeUserServiceImpl implements ResumeUserService {


    @Autowired
    private ResumeUserMapper resumeMapper;


    @Override
    public AjaxResult getUserInfoByUserId(Long userId){
        return AjaxResult.success(resumeMapper.selectUserInfoByUserId(userId));
    }


    @Override
    public AjaxResult updateResumeInfo(ResumeJob resume)
    {

//        ResumeJob user_resume = resumeMapper.selectUserInfoByUserId(resume.getUserId());

//        user_resume.setUpdateTime(DateUtils.getNowDate());
        ResumeJob debug = resume;
        return AjaxResult.success(resumeMapper.updateResumeInfo(resume));
    }

    @Override
    public List<InterviewDto> getInterviewInfo(Interview i) {
        if("已投递".equals(i.getInterviewStatus())) i.setInterviewStatus(null);
        List<Interview> interviews = resumeMapper.selectInterviewInfoByUserIdAndStatus(i);
        List<Long> jobIds = interviews.stream().map(Interview::getJobId).collect(Collectors.toList());
        List<Long> etpIds = interviews.stream().map(Interview::getEtpId).collect(Collectors.toList());


        List<Job> jobs = resumeMapper.selectJobInfoByJobId(jobIds);
        List<Etp> etps = resumeMapper.selectEtpInfoByEtpId(etpIds);


        Map<Long, Job> jobMap = jobs.stream()
                .collect(Collectors.toMap(
                        Job::getId,           // 假设 Job 有 getJobId() 方法
                        Function.identity(),
                        (existing, replacement) -> existing // 若有重复 jobId，保留第一个
                ));
        Map<Long, Etp> etpMap = etps.stream()
                .collect(Collectors.toMap(
                        Etp::getId,           // 假设 Job 有 getJobId() 方法
                        Function.identity(),
                        (existing, replacement) -> existing // 若有重复 jobId，保留第一个
                ));


// 合并 interviews 和 jobs
        List<InterviewDto> mergedList = interviews.stream()
                .map(interview -> {
                    Job job = jobMap.get(interview.getJobId());
                    Etp etp = etpMap.get(interview.getEtpId());
                    if (job != null) {
                        return new InterviewDto(
                                interview.getId(),
                                interview.getJobId(),
                                job.getRequirement(),
                                job.getLocation(),
                                job.getSalaryDesc(),
                                job.getEtpId(),      // 假设 Job 有 getEtpId()
                                job.getName(),   // 假设 Job 有 getEtpId()
                                etp.getLogoFileId(),
                                etp.getName()
                        );
                    } else {
                        return null; // 无匹配 Job 的 Interview，按需处理
                    }
                })
                .filter(Objects::nonNull) // 过滤掉无匹配项（可选）
                .collect(Collectors.toList());

        for (InterviewDto dto : mergedList) {
            // 操作 dto 对象，例如：\
            if (!etpMap.isEmpty() && etpMap.containsKey(dto.getEtpId())) {
                dto.setLogo(etpMap.get(dto.getEtpId()).getLogoFileId());
                dto.setEtpName(etpMap.get(dto.getEtpId()).getName());
            }
        }


        int debug = 1;
        return mergedList;
    }


    @Override
    public AjaxResult getResumesImgInfo(Long userId){
        String imgIds = resumeMapper.getResumesImgInfoByUserId(userId);
        List<String> list = new ArrayList<>();
        if (imgIds == null || imgIds.isEmpty()) {
            return null;
        }
        String[] parts = imgIds.split(",");
        for (String part : parts) {
            String trimmed = part.trim();
            if (!trimmed.isEmpty()) {
                list.add(trimmed);
            }
        }

        return AjaxResult.success(list);
    }


}
