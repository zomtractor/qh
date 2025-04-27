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
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.service.IResumeService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 简历Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/resume")
public class ResumeController extends BaseController
{
    @Autowired
    private IResumeService resumeService;

    /**
     * 查询简历列表
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:list')")
    @GetMapping("/list")
    public TableDataInfo list(Resume resume)
    {
        startPage();
        List<Resume> list = resumeService.selectResumeList(resume);
        return getDataTable(list);
    }

    /**
     * 导出简历列表
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:export')")
    @Log(title = "简历", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Resume resume)
    {
        List<Resume> list = resumeService.selectResumeList(resume);
        ExcelUtil<Resume> util = new ExcelUtil<Resume>(Resume.class);
        util.exportExcel(response, list, "简历数据");
    }

    /**
     * 获取简历详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(resumeService.selectResumeById(id));
    }

    /**
     * 新增简历
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:add')")
    @Log(title = "简历", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Resume resume)
    {
        return toAjax(resumeService.insertResume(resume));
    }

    /**
     * 修改简历
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:edit')")
    @Log(title = "简历", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Resume resume)
    {
        return toAjax(resumeService.updateResume(resume));
    }

    /**
     * 删除简历
     */
    @PreAuthorize("@ss.hasPermi('admin:resume:remove')")
    @Log(title = "简历", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(resumeService.deleteResumeByIds(ids));
    }
}
