package com.qh.recruit.admin.service;

import java.util.List;
import com.qh.recruit.admin.domain.Tag;

/**
 * 标签管理Service接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface ITagService 
{
    /**
     * 查询标签管理
     * 
     * @param id 标签管理主键
     * @return 标签管理
     */
    public Tag selectTagById(Long id);

    /**
     * 查询标签管理列表
     * 
     * @param tag 标签管理
     * @return 标签管理集合
     */
    public List<Tag> selectTagList(Tag tag);

    /**
     * 新增标签管理
     * 
     * @param tag 标签管理
     * @return 结果
     */
    public int insertTag(Tag tag);

    /**
     * 修改标签管理
     * 
     * @param tag 标签管理
     * @return 结果
     */
    public int updateTag(Tag tag);

    /**
     * 批量删除标签管理
     * 
     * @param ids 需要删除的标签管理主键集合
     * @return 结果
     */
    public int deleteTagByIds(Long[] ids);

    /**
     * 删除标签管理信息
     * 
     * @param id 标签管理主键
     * @return 结果
     */
    public int deleteTagById(Long id);
}
