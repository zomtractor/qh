package com.qh.recruit.admin.service;

import java.util.List;
import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.dto.InterviewDto;

/**
 * 面试Service接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface IInterviewService 
{
    /**
     * 查询面试
     * 
     * @param id 面试主键
     * @return 面试
     */
    public Interview selectInterviewById(Long id);

    /**
     * 查询面试列表
     * 
     * @param interview 面试
     * @return 面试集合
     */
    public List<Interview> selectInterviewList(Interview interview);
    public List<InterviewDto> selectInterviewDtoList(InterviewDto interview);

    /**
     * 新增面试
     * 
     * @param interview 面试
     * @return 结果
     */
    public int insertInterview(Interview interview);

    /**
     * 修改面试
     * 
     * @param interview 面试
     * @return 结果
     */
    public int updateInterview(Interview interview);

    /**
     * 批量删除面试
     * 
     * @param ids 需要删除的面试主键集合
     * @return 结果
     */
    public int deleteInterviewByIds(Long[] ids);

    /**
     * 删除面试信息
     * 
     * @param id 面试主键
     * @return 结果
     */
    public int deleteInterviewById(Long id);
}
