package com.qh.recruit.user.service.impl;

import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.mapper.CommunicateMapper;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.mapper.JobMapper;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.user.service.JobSeekerService;
import com.qh.recruit.user.util.UserHolder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class JobSeekerServiceImpl implements JobSeekerService {
    @Resource
    private JobMapper jobMapper;

    @Resource
    private EtpMapper etpMapper;
    @Resource
    private CommunicateMapper communicateMapper;
    @Override
    public AjaxResult contact(Long jobId) {
        Job job = jobMapper.selectJobById(jobId);
        if (job == null) {
            return AjaxResult.error("Job not found");
        }
        Etp etp = etpMapper.selectEtpByUserId(job.getEtpId());
        if(etp == null) {
            return AjaxResult.error("Company not found");
        }
        List<Communicate> communicates = communicateMapper.selectListByPeerId(UserHolder.getUser().getId(), etp.getUserId());
        Communicate communicate = new Communicate();
        communicate.setPosterId(UserHolder.getUser().getId());
        communicate.setReceiverId(etp.getUserId());
        communicate.setContentType("text");
        communicate.setContent("您好，我对贵公司的职位 " + job.getName() + " 感兴趣，想了解更多信息。");
        if (communicates.isEmpty()) {
            communicate.setPreviousId(-1L);
        } else {
            Communicate last = communicates.get(communicates.size()-1);
            communicate.setPreviousId(last.getId());
        }
        communicateMapper.insertCommunicate(communicate);
        etp.setPopularity(etp.getPopularity()+2);
        job.setPopularity(job.getPopularity()+2);
        etpMapper.updateEtp(etp);
        jobMapper.updateJob(job);
        return AjaxResult.success();
    }
}
