package com.qh.recruit.admin.mapper;

import java.util.List;
import com.qh.recruit.admin.domain.Communicate;
import org.apache.ibatis.annotations.Mapper;

/**
 * 沟通Mapper接口
 * 
 * @author ruoyi
 * @date 2025-05-02
 */
@Mapper
public interface CommunicateMapper 
{
    /**
     * 查询沟通
     * 
     * @param id 沟通主键
     * @return 沟通
     */
    public Communicate selectCommunicateById(Long id);

    /**
     * 查询沟通列表
     * 
     * @param communicate 沟通
     * @return 沟通集合
     */
    public List<Communicate> selectCommunicateList(Communicate communicate);

    /**
     * 新增沟通
     * 
     * @param communicate 沟通
     * @return 结果
     */
    public int insertCommunicate(Communicate communicate);

    /**
     * 修改沟通
     * 
     * @param communicate 沟通
     * @return 结果
     */
    public int updateCommunicate(Communicate communicate);

    /**
     * 删除沟通
     * 
     * @param id 沟通主键
     * @return 结果
     */
    public int deleteCommunicateById(Long id);

    /**
     * 批量删除沟通
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCommunicateByIds(Long[] ids);

    public int selectListByPeerId(Long id1, Long id2);
}
