package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.CommunicateMapper;
import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.admin.service.ICommunicateService;

/**
 * 沟通Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-05-02
 */
@Service
public class CommunicateServiceImpl implements ICommunicateService 
{
    @Autowired
    private CommunicateMapper communicateMapper;

    /**
     * 查询沟通
     * 
     * @param id 沟通主键
     * @return 沟通
     */
    @Override
    public Communicate selectCommunicateById(Long id)
    {
        return communicateMapper.selectCommunicateById(id);
    }

    /**
     * 查询沟通列表
     * 
     * @param communicate 沟通
     * @return 沟通
     */
    @Override
    public List<Communicate> selectCommunicateList(Communicate communicate)
    {
        return communicateMapper.selectCommunicateList(communicate);
    }

    /**
     * 新增沟通
     * 
     * @param communicate 沟通
     * @return 结果
     */
    @Override
    public int insertCommunicate(Communicate communicate)
    {
        communicate.setCreateTime(DateUtils.getNowDate());
        return communicateMapper.insertCommunicate(communicate);
    }

    /**
     * 修改沟通
     * 
     * @param communicate 沟通
     * @return 结果
     */
    @Override
    public int updateCommunicate(Communicate communicate)
    {
        communicate.setUpdateTime(DateUtils.getNowDate());
        return communicateMapper.updateCommunicate(communicate);
    }

    /**
     * 批量删除沟通
     * 
     * @param ids 需要删除的沟通主键
     * @return 结果
     */
    @Override
    public int deleteCommunicateByIds(Long[] ids)
    {
        return communicateMapper.deleteCommunicateByIds(ids);
    }

    /**
     * 删除沟通信息
     * 
     * @param id 沟通主键
     * @return 结果
     */
    @Override
    public int deleteCommunicateById(Long id)
    {
        return communicateMapper.deleteCommunicateById(id);
    }
}
