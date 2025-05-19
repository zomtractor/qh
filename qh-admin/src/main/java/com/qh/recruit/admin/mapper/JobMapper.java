package com.qh.recruit.admin.mapper;

import java.util.List;
import com.qh.recruit.admin.domain.Job;

/**
 * 岗位Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface JobMapper 
{
    /**
     * 查询岗位
     * 
     * @param id 岗位主键
     * @return 岗位
     */
    public Job selectJobById(Long id);

    /**
     * 查询岗位列表
     * 
     * @param job 岗位
     * @return 岗位集合
     */
    public List<Job> selectJobList(Job job);

    /**
     * 新增岗位
     * 
     * @param job 岗位
     * @return 结果
     */
    public int insertJob(Job job);

    /**
     * 修改岗位
     * 
     * @param job 岗位
     * @return 结果
     */
    public int updateJob(Job job);

    /**
     * 删除岗位
     * 
     * @param id 岗位主键
     * @return 结果
     */
    public int deleteJobById(Long id);

    /**
     * 批量删除岗位
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteJobByIds(Long[] ids);
}
