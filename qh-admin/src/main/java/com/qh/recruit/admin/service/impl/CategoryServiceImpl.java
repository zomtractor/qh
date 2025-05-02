package com.qh.recruit.admin.service.impl;

import java.util.List;
import com.qh.recruit.common.utils.DateUtils;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.qh.recruit.admin.mapper.CategoryMapper;
import com.qh.recruit.admin.domain.Category;
import com.qh.recruit.admin.service.ICategoryService;

/**
 * 分类管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@Service
public class CategoryServiceImpl implements ICategoryService 
{
    @Resource
    private CategoryMapper categoryMapper;

    /**
     * 查询分类管理
     * 
     * @param id 分类管理主键
     * @return 分类管理
     */
    @Override
    public Category selectCategoryById(Long id)
    {
        return categoryMapper.selectCategoryById(id);
    }

    /**
     * 查询分类管理列表
     * 
     * @param category 分类管理
     * @return 分类管理
     */
    @Override
    public List<Category> selectCategoryList(Category category)
    {
        return categoryMapper.selectCategoryList(category);
    }

    /**
     * 新增分类管理
     * 
     * @param category 分类管理
     * @return 结果
     */
    @Override
    public int insertCategory(Category category)
    {
        category.setCreateTime(DateUtils.getNowDate());
        int i = categoryMapper.insertCategory(category);
        return i;
    }

    /**
     * 修改分类管理
     * 
     * @param category 分类管理
     * @return 结果
     */
    @Override
    public int updateCategory(Category category)
    {
        category.setUpdateTime(DateUtils.getNowDate());
        return categoryMapper.updateCategory(category);
    }

    /**
     * 批量删除分类管理
     * 
     * @param ids 需要删除的分类管理主键
     * @return 结果
     */
    @Override
    public int deleteCategoryByIds(Long[] ids)
    {
        return categoryMapper.deleteCategoryByIds(ids);
    }

    /**
     * 删除分类管理信息
     * 
     * @param id 分类管理主键
     * @return 结果
     */
    @Override
    public int deleteCategoryById(Long id)
    {
        return categoryMapper.deleteCategoryById(id);
    }
}
