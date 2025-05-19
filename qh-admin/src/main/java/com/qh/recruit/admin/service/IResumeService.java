package com.qh.recruit.admin.service;

import java.util.List;
import com.qh.recruit.admin.domain.Resume;

/**
 * 简历Service接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface IResumeService 
{
    /**
     * 查询简历
     * 
     * @param id 简历主键
     * @return 简历
     */
    public Resume selectResumeById(Long id);

    /**
     * 查询简历列表
     * 
     * @param resume 简历
     * @return 简历集合
     */
    public List<Resume> selectResumeList(Resume resume);

    /**
     * 新增简历
     * 
     * @param resume 简历
     * @return 结果
     */
    public int insertResume(Resume resume);

    /**
     * 修改简历
     * 
     * @param resume 简历
     * @return 结果
     */
    public int updateResume(Resume resume);

    /**
     * 批量删除简历
     * 
     * @param ids 需要删除的简历主键集合
     * @return 结果
     */
    public int deleteResumeByIds(Long[] ids);

    /**
     * 删除简历信息
     * 
     * @param id 简历主键
     * @return 结果
     */
    public int deleteResumeById(Long id);
}
