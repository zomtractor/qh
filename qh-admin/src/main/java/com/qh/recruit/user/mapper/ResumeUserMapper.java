package com.qh.recruit.user.mapper;


import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.user.domain.ResumeJob;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ResumeUserMapper {

    public ResumeJob selectUserInfoByUserId(Long userId);

    public boolean updateResumeInfo(ResumeJob resume);

    public List<Interview> selectInterviewInfoByUserIdAndStatus(Interview interview);

    public List<Job> selectJobInfoByJobId(@Param("jobIds") List<Long> jobIds);

}
