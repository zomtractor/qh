package com.qh.recruit.admin.service;

import java.util.List;
import com.qh.recruit.admin.domain.Etp;

/**
 * 企业管理Service接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface IEtpService 
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
     * 批量删除企业管理
     * 
     * @param ids 需要删除的企业管理主键集合
     * @return 结果
     */
    public int deleteEtpByIds(Long[] ids);

    /**
     * 删除企业管理信息
     * 
     * @param id 企业管理主键
     * @return 结果
     */
    public int deleteEtpById(Long id);

    Etp selectEtpByUserId(Long id);
}
