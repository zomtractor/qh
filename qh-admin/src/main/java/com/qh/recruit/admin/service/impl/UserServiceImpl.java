package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.UserMapper;
import com.qh.recruit.admin.domain.User;
import com.qh.recruit.admin.service.IUserService;

/**
 * 用户管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class UserServiceImpl implements IUserService 
{
    @Resource
    private UserMapper userMapper;

    /**
     * 查询用户管理
     * 
     * @param id 用户管理主键
     * @return 用户管理
     */
    @Override
    public User selectUserById(Long id)
    {
        return userMapper.selectUserById(id);
    }

    /**
     * 查询用户管理列表
     * 
     * @param user 用户管理
     * @return 用户管理
     */
    @Override
    public List<User> selectUserList(User user)
    {
        return userMapper.selectUserList(user);
    }

    /**
     * 新增用户管理
     * 
     * @param user 用户管理
     * @return 结果
     */
    @Override
    public int insertUser(User user)
    {
        user.setCreateTime(DateUtils.getNowDate());
        return userMapper.insertUser(user);
    }

    /**
     * 修改用户管理
     * 
     * @param user 用户管理
     * @return 结果
     */
    @Override
    public int updateUser(User user)
    {
        user.setUpdateTime(DateUtils.getNowDate());
        return userMapper.updateUser(user);
    }

    /**
     * 批量删除用户管理
     * 
     * @param ids 需要删除的用户管理主键
     * @return 结果
     */
    @Override
    public int deleteUserByIds(Long[] ids)
    {
        return userMapper.deleteUserByIds(ids);
    }

    /**
     * 删除用户管理信息
     * 
     * @param id 用户管理主键
     * @return 结果
     */
    @Override
    public int deleteUserById(Long id)
    {
        return userMapper.deleteUserById(id);
    }
}
