package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.CommentMapper;
import com.qh.recruit.admin.domain.Comment;
import com.qh.recruit.admin.service.ICommentService;

/**
 * 评价Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class CommentServiceImpl implements ICommentService 
{
    @Autowired
    private CommentMapper commentMapper;

    /**
     * 查询评价
     * 
     * @param id 评价主键
     * @return 评价
     */
    @Override
    public Comment selectCommentById(Long id)
    {
        return commentMapper.selectCommentById(id);
    }

    /**
     * 查询评价列表
     * 
     * @param comment 评价
     * @return 评价
     */
    @Override
    public List<Comment> selectCommentList(Comment comment)
    {
        return commentMapper.selectCommentList(comment);
    }

    /**
     * 新增评价
     * 
     * @param comment 评价
     * @return 结果
     */
    @Override
    public int insertComment(Comment comment)
    {
        comment.setCreateTime(DateUtils.getNowDate());
        return commentMapper.insertComment(comment);
    }

    /**
     * 修改评价
     * 
     * @param comment 评价
     * @return 结果
     */
    @Override
    public int updateComment(Comment comment)
    {
        comment.setUpdateTime(DateUtils.getNowDate());
        return commentMapper.updateComment(comment);
    }

    /**
     * 批量删除评价
     * 
     * @param ids 需要删除的评价主键
     * @return 结果
     */
    @Override
    public int deleteCommentByIds(Long[] ids)
    {
        return commentMapper.deleteCommentByIds(ids);
    }

    /**
     * 删除评价信息
     * 
     * @param id 评价主键
     * @return 结果
     */
    @Override
    public int deleteCommentById(Long id)
    {
        return commentMapper.deleteCommentById(id);
    }
}
