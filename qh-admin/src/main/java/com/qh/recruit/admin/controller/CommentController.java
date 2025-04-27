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
import com.qh.recruit.admin.domain.Comment;
import com.qh.recruit.admin.service.ICommentService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 评价Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/comment")
public class CommentController extends BaseController
{
    @Autowired
    private ICommentService commentService;

    /**
     * 查询评价列表
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(Comment comment)
    {
        startPage();
        List<Comment> list = commentService.selectCommentList(comment);
        return getDataTable(list);
    }

    /**
     * 导出评价列表
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:export')")
    @Log(title = "评价", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Comment comment)
    {
        List<Comment> list = commentService.selectCommentList(comment);
        ExcelUtil<Comment> util = new ExcelUtil<Comment>(Comment.class);
        util.exportExcel(response, list, "评价数据");
    }

    /**
     * 获取评价详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(commentService.selectCommentById(id));
    }

    /**
     * 新增评价
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:add')")
    @Log(title = "评价", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Comment comment)
    {
        return toAjax(commentService.insertComment(comment));
    }

    /**
     * 修改评价
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:edit')")
    @Log(title = "评价", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Comment comment)
    {
        return toAjax(commentService.updateComment(comment));
    }

    /**
     * 删除评价
     */
    @PreAuthorize("@ss.hasPermi('admin:comment:remove')")
    @Log(title = "评价", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(commentService.deleteCommentByIds(ids));
    }
}
