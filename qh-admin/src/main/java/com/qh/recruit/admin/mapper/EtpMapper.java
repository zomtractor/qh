package com.qh.recruit.admin.mapper;

import java.util.List;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.dto.EtpDto;
import com.qh.recruit.admin.domain.dto.ResumeDto;
import com.qh.recruit.user.domain.LoginDto;

/**
 * 企业管理Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface EtpMapper 
{
    /**
     * 查询企业管理
     * 
     * @param id 企业管理主键
     * @return 企业管理
     */
    public Etp selectEtpById(Long id);

    /**
     * 查询企业管理列表
     * 
     * @param etp 企业管理
     * @return 企业管理集合
     */
    public List<Etp> selectEtpList(Etp etp);

    /**
     * 新增企业管理
     * 
     * @param etp 企业管理
     * @return 结果
     */
    public int insertEtp(Etp etp);

    /**
     * 修改企业管理
     * 
     * @param etp 企业管理
     * @return 结果
     */
    public int updateEtp(Etp etp);

    /**
     * 删除企业管理
     * 
     * @param id 企业管理主键
     * @return 结果
     */
    public int deleteEtpById(Long id);

    /**
     * 批量删除企业管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEtpByIds(Long[] ids);

    Etp selectEtpByUserId(Long id);

    public List<LoginDto> selectEtpChatted(Long userId);
}
