package com.qh.recruit.admin.mapper;

import java.util.List;
import com.qh.recruit.admin.domain.Comment;

/**
 * 评价Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface CommentMapper 
{
    /**
     * 查询评价
     * 
     * @param id 评价主键
     * @return 评价
     */
    public Comment selectCommentById(Long id);

    /**
     * 查询评价列表
     * 
     * @param comment 评价
     * @return 评价集合
     */
    public List<Comment> selectCommentList(Comment comment);

    /**
     * 新增评价
     * 
     * @param comment 评价
     * @return 结果
     */
    public int insertComment(Comment comment);

    /**
     * 修改评价
     * 
     * @param comment 评价
     * @return 结果
     */
    public int updateComment(Comment comment);

    /**
     * 删除评价
     * 
     * @param id 评价主键
     * @return 结果
     */
    public int deleteCommentById(Long id);

    /**
     * 批量删除评价
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCommentByIds(Long[] ids);
}
