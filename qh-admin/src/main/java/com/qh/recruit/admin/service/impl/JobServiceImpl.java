package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.JobMapper;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.service.IJobService;

/**
 * 岗位Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class JobServiceImpl implements IJobService 
{
    @Autowired
    private JobMapper jobMapper;

    /**
     * 查询岗位
     * 
     * @param id 岗位主键
     * @return 岗位
     */
    @Override
    public Job selectJobById(Long id)
    {
        return jobMapper.selectJobById(id);
    }

    /**
     * 查询岗位列表
     * 
     * @param job 岗位
     * @return 岗位
     */
    @Override
    public List<Job> selectJobList(Job job)
    {
        return jobMapper.selectJobList(job);
    }

    /**
     * 新增岗位
     * 
     * @param job 岗位
     * @return 结果
     */
    @Override
    public int insertJob(Job job)
    {
        job.setCreateTime(DateUtils.getNowDate());
        return jobMapper.insertJob(job);
    }

    /**
     * 修改岗位
     * 
     * @param job 岗位
     * @return 结果
     */
    @Override
    public int updateJob(Job job)
    {
        job.setUpdateTime(DateUtils.getNowDate());
        return jobMapper.updateJob(job);
    }

    /**
     * 批量删除岗位
     * 
     * @param ids 需要删除的岗位主键
     * @return 结果
     */
    @Override
    public int deleteJobByIds(Long[] ids)
    {
        return jobMapper.deleteJobByIds(ids);
    }

    /**
     * 删除岗位信息
     * 
     * @param id 岗位主键
     * @return 结果
     */
    @Override
    public int deleteJobById(Long id)
    {
        return jobMapper.deleteJobById(id);
    }
}
