package com.qh.recruit.admin.test;

import com.qh.recruit.RuoYiApplication;
import com.qh.recruit.admin.domain.dto.JobDto;
import com.qh.recruit.admin.service.IJobService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@SpringBootTest(classes = RuoYiApplication.class)
public class ServiceTest {

    @Resource
    private IJobService jobService;

    @Test
    public void test() {
        JobDto dto = (JobDto) jobService.selectJobById(1L);
        System.out.println(dto  );
    }
}
