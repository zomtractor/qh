package com.qh.recruit.admin.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.qh.recruit.common.annotation.Log;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.enums.BusinessType;
import com.qh.recruit.admin.domain.Tag;
import com.qh.recruit.admin.service.ITagService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 标签管理Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/tag")
public class TagController extends BaseController
{
    @Autowired
    private ITagService tagService;

    /**
     * 查询标签管理列表
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:list')")
    @GetMapping("/list")
    public TableDataInfo list(Tag tag)
    {
        startPage();
        List<Tag> list = tagService.selectTagList(tag);
        return getDataTable(list);
    }

    /**
     * 导出标签管理列表
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:export')")
    @Log(title = "标签管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Tag tag)
    {
        List<Tag> list = tagService.selectTagList(tag);
        ExcelUtil<Tag> util = new ExcelUtil<Tag>(Tag.class);
        util.exportExcel(response, list, "标签管理数据");
    }

    /**
     * 获取标签管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tagService.selectTagById(id));
    }

    /**
     * 新增标签管理
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:add')")
    @Log(title = "标签管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Tag tag)
    {
        return toAjax(tagService.insertTag(tag));
    }

    /**
     * 修改标签管理
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:edit')")
    @Log(title = "标签管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Tag tag)
    {
        return toAjax(tagService.updateTag(tag));
    }

    /**
     * 删除标签管理
     */
    @PreAuthorize("@ss.hasPermi('admin:tag:remove')")
    @Log(title = "标签管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tagService.deleteTagByIds(ids));
    }
}
