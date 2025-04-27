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
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.service.IJobService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 岗位Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/job")
public class JobController extends BaseController
{
    @Autowired
    private IJobService jobService;

    /**
     * 查询岗位列表
     */
    @PreAuthorize("@ss.hasPermi('admin:job:list')")
    @GetMapping("/list")
    public TableDataInfo list(Job job)
    {
        startPage();
        List<Job> list = jobService.selectJobList(job);
        return getDataTable(list);
    }

    /**
     * 导出岗位列表
     */
    @PreAuthorize("@ss.hasPermi('admin:job:export')")
    @Log(title = "岗位", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Job job)
    {
        List<Job> list = jobService.selectJobList(job);
        ExcelUtil<Job> util = new ExcelUtil<Job>(Job.class);
        util.exportExcel(response, list, "岗位数据");
    }

    /**
     * 获取岗位详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:job:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(jobService.selectJobById(id));
    }

    /**
     * 新增岗位
     */
    @PreAuthorize("@ss.hasPermi('admin:job:add')")
    @Log(title = "岗位", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Job job)
    {
        return toAjax(jobService.insertJob(job));
    }

    /**
     * 修改岗位
     */
    @PreAuthorize("@ss.hasPermi('admin:job:edit')")
    @Log(title = "岗位", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Job job)
    {
        return toAjax(jobService.updateJob(job));
    }

    /**
     * 删除岗位
     */
    @PreAuthorize("@ss.hasPermi('admin:job:remove')")
    @Log(title = "岗位", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(jobService.deleteJobByIds(ids));
    }
}
