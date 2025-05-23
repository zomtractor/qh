package com.qh.recruit.admin.service.impl;

import java.util.List;

import com.qh.recruit.admin.domain.dto.InterviewDto;
import com.qh.recruit.common.utils.DateUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.InterviewMapper;
import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.service.IInterviewService;

/**
 * 面试Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class InterviewServiceImpl implements IInterviewService 
{
    @Resource
    private InterviewMapper interviewMapper;

    /**
     * 查询面试
     * 
     * @param id 面试主键
     * @return 面试
     */
    @Override
    public Interview selectInterviewById(Long id)
    {
        return interviewMapper.selectInterviewById(id);
    }

    /**
     * 查询面试列表
     * 
     * @param interview 面试
     * @return 面试
     */
    @Override
    public List<Interview> selectInterviewList(Interview interview)
    {
        return interviewMapper.selectInterviewList(interview);
    }

    @Override
    public List<InterviewDto> selectInterviewDtoList(InterviewDto interview)
    {
        return interviewMapper.selectInterviewDtoList(interview);
    }

    /**
     * 新增面试
     * 
     * @param interview 面试
     * @return 结果
     */
    @Override
    public int insertInterview(Interview interview)
    {
        interview.setCreateTime(DateUtils.getNowDate());
        return interviewMapper.insertInterview(interview);
    }

    /**
     * 修改面试
     * 
     * @param interview 面试
     * @return 结果
     */
    @Override
    public int updateInterview(Interview interview)
    {
        interview.setUpdateTime(DateUtils.getNowDate());
        return interviewMapper.updateInterview(interview);
    }

    /**
     * 批量删除面试
     * 
     * @param ids 需要删除的面试主键
     * @return 结果
     */
    @Override
    public int deleteInterviewByIds(Long[] ids)
    {
        return interviewMapper.deleteInterviewByIds(ids);
    }

    /**
     * 删除面试信息
     * 
     * @param id 面试主键
     * @return 结果
     */
    @Override
    public int deleteInterviewById(Long id)
    {
        return interviewMapper.deleteInterviewById(id);
    }
}
