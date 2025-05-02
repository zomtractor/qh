package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.ResumeMapper;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.service.IResumeService;

/**
 * 简历Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class ResumeServiceImpl implements IResumeService 
{
    @Resource
    private ResumeMapper resumeMapper;

    /**
     * 查询简历
     * 
     * @param id 简历主键
     * @return 简历
     */
    @Override
    public Resume selectResumeById(Long id)
    {
        return resumeMapper.selectResumeById(id);
    }

    /**
     * 查询简历列表
     * 
     * @param resume 简历
     * @return 简历
     */
    @Override
    public List<Resume> selectResumeList(Resume resume)
    {
        return resumeMapper.selectResumeList(resume);
    }

    /**
     * 新增简历
     * 
     * @param resume 简历
     * @return 结果
     */
    @Override
    public int insertResume(Resume resume)
    {
        resume.setCreateTime(DateUtils.getNowDate());
        return resumeMapper.insertResume(resume);
    }

    /**
     * 修改简历
     * 
     * @param resume 简历
     * @return 结果
     */
    @Override
    public int updateResume(Resume resume)
    {
        resume.setUpdateTime(DateUtils.getNowDate());
        return resumeMapper.updateResume(resume);
    }

    /**
     * 批量删除简历
     * 
     * @param ids 需要删除的简历主键
     * @return 结果
     */
    @Override
    public int deleteResumeByIds(Long[] ids)
    {
        return resumeMapper.deleteResumeByIds(ids);
    }

    /**
     * 删除简历信息
     * 
     * @param id 简历主键
     * @return 结果
     */
    @Override
    public int deleteResumeById(Long id)
    {
        return resumeMapper.deleteResumeById(id);
    }
}
