package com.qh.recruit.admin.mapper;

import java.util.List;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.domain.dto.ResumeDto;
import com.qh.recruit.user.domain.LoginDto;

/**
 * 简历Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface ResumeMapper 
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
     * 删除简历
     * 
     * @param id 简历主键
     * @return 结果
     */
    public int deleteResumeById(Long id);

    /**
     * 批量删除简历
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteResumeByIds(Long[] ids);

    public ResumeDto selectResumeByUserId(Long userId);

    public List<LoginDto> selectResumeChatted(Long userId);
}
