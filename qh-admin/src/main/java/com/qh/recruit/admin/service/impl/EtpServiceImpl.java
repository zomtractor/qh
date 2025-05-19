package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.EtpMapper;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.service.IEtpService;

/**
 * 企业管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class EtpServiceImpl implements IEtpService 
{
    @Resource
    private EtpMapper etpMapper;

    /**
     * 查询企业管理
     * 
     * @param id 企业管理主键
     * @return 企业管理
     */
    @Override
    public Etp selectEtpById(Long id)
    {
        return etpMapper.selectEtpById(id);
    }

    /**
     * 查询企业管理列表
     * 
     * @param etp 企业管理
     * @return 企业管理
     */
    @Override
    public List<Etp> selectEtpList(Etp etp)
    {
        return etpMapper.selectEtpList(etp);
    }

    /**
     * 新增企业管理
     * 
     * @param etp 企业管理
     * @return 结果
     */
    @Override
    public int insertEtp(Etp etp)
    {
        etp.setCreateTime(DateUtils.getNowDate());
        return etpMapper.insertEtp(etp);
    }

    /**
     * 修改企业管理
     * 
     * @param etp 企业管理
     * @return 结果
     */
    @Override
    public int updateEtp(Etp etp)
    {
        etp.setUpdateTime(DateUtils.getNowDate());
        return etpMapper.updateEtp(etp);
    }

    /**
     * 批量删除企业管理
     * 
     * @param ids 需要删除的企业管理主键
     * @return 结果
     */
    @Override
    public int deleteEtpByIds(Long[] ids)
    {
        return etpMapper.deleteEtpByIds(ids);
    }

    /**
     * 删除企业管理信息
     * 
     * @param id 企业管理主键
     * @return 结果
     */
    @Override
    public int deleteEtpById(Long id)
    {
        return etpMapper.deleteEtpById(id);
    }
}
