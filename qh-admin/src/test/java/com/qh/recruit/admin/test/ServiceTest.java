package com.qh.recruit.admin.test;

import com.qh.recruit.RuoYiApplication;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.domain.dto.JobDto;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.admin.service.IJobService;
import com.qh.recruit.common.core.domain.model.LoginUser;
import com.qh.recruit.user.domain.JobRecommendQuery;

import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.mapper.RecommendInterviewMapper;
import com.qh.recruit.user.mapper.RecommendJobMapper;
import com.qh.recruit.user.mapper.RecommendResumeMapper;
import com.qh.recruit.user.service.RecommendService;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest(classes = RuoYiApplication.class)
@MapperScan(basePackages = "com.qh.recruit.user.mapper")
public class ServiceTest {

    @Autowired
    private IJobService jobService;

    @Resource
    private RecommendService recommendService;
    @Resource
    private RecommendInterviewMapper recInterviewMapper;
    @Resource
    private RecommendResumeMapper recResumeMapper;
    @Resource
    private RecommendJobMapper recJobMapper;

    @Resource
    private ResumeMapper resumeMapper;
    @Test
    public void test() {
        JobDto dto = (JobDto) jobService.selectJobById(1L);
        System.out.println(dto  );
    }
    @Test
    public void test1() {
        JobRecommendQuery query = new JobRecommendQuery();
        query.setPriority("hot");
        query.setPage(1);
        query.setPageSize(10);
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(1L);
        ResumeJob resume = recResumeMapper.selectResumeById(loginUser.getUserId());
        Resume resume1 = resumeMapper.selectResumeById(1L);
        //System.out.println(resume1);
        System.out.println(resume);

    }

}
