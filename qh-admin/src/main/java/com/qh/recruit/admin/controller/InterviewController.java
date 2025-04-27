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
import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.service.IInterviewService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 面试Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/interview")
public class InterviewController extends BaseController
{
    @Autowired
    private IInterviewService interviewService;

    /**
     * 查询面试列表
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:list')")
    @GetMapping("/list")
    public TableDataInfo list(Interview interview)
    {
        startPage();
        List<Interview> list = interviewService.selectInterviewList(interview);
        return getDataTable(list);
    }

    /**
     * 导出面试列表
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:export')")
    @Log(title = "面试", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Interview interview)
    {
        List<Interview> list = interviewService.selectInterviewList(interview);
        ExcelUtil<Interview> util = new ExcelUtil<Interview>(Interview.class);
        util.exportExcel(response, list, "面试数据");
    }

    /**
     * 获取面试详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(interviewService.selectInterviewById(id));
    }

    /**
     * 新增面试
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:add')")
    @Log(title = "面试", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Interview interview)
    {
        return toAjax(interviewService.insertInterview(interview));
    }

    /**
     * 修改面试
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:edit')")
    @Log(title = "面试", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Interview interview)
    {
        return toAjax(interviewService.updateInterview(interview));
    }

    /**
     * 删除面试
     */
    @PreAuthorize("@ss.hasPermi('admin:interview:remove')")
    @Log(title = "面试", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(interviewService.deleteInterviewByIds(ids));
    }
}
