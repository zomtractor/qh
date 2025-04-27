package com.qh.recruit.admin.service;

import java.util.List;
import com.qh.recruit.admin.domain.User;

/**
 * 用户管理Service接口
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public interface IUserService 
{
    /**
     * 查询用户管理
     * 
     * @param id 用户管理主键
     * @return 用户管理
     */
    public User selectUserById(Long id);

    /**
     * 查询用户管理列表
     * 
     * @param user 用户管理
     * @return 用户管理集合
     */
    public List<User> selectUserList(User user);

    /**
     * 新增用户管理
     * 
     * @param user 用户管理
     * @return 结果
     */
    public int insertUser(User user);

    /**
     * 修改用户管理
     * 
     * @param user 用户管理
     * @return 结果
     */
    public int updateUser(User user);

    /**
     * 批量删除用户管理
     * 
     * @param ids 需要删除的用户管理主键集合
     * @return 结果
     */
    public int deleteUserByIds(Long[] ids);

    /**
     * 删除用户管理信息
     * 
     * @param id 用户管理主键
     * @return 结果
     */
    public int deleteUserById(Long id);
}
