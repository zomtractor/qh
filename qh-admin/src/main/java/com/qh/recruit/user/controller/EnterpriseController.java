package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.service.IJobService;
import com.qh.recruit.common.annotation.Log;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.common.enums.BusinessType;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/etp")
public class EnterpriseController extends BaseController {
    @Resource
    private IJobService jobService;

    @GetMapping("/job/list")
    public TableDataInfo list(Job job)
    {
        startPage();
        List<Job> list = jobService.selectJobList(job);
        return getDataTable(list);
    }

    /**
     * 获取岗位详细信息
     */
    @GetMapping("/job/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(jobService.selectJobById(id));
    }

    /**
     * 新增岗位
     */
    @Log(title = "岗位", businessType = BusinessType.INSERT)
    @PostMapping("/job")
    public AjaxResult add(@RequestBody Job job)
    {
        return toAjax(jobService.insertJob(job));
    }

    /**
     * 修改岗位
     */
    @Log(title = "岗位", businessType = BusinessType.UPDATE)
    @PutMapping("/job")
    public AjaxResult edit(@RequestBody Job job)
    {
        return toAjax(jobService.updateJob(job));
    }

    /**
     * 删除岗位
     */
    @Log(title = "岗位", businessType = BusinessType.DELETE)
    @DeleteMapping("/job/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(jobService.deleteJobByIds(ids));
    }
}
