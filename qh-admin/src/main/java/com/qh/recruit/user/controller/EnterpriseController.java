package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Category;
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.Tag;
import com.qh.recruit.admin.service.ICategoryService;
import com.qh.recruit.admin.service.IEtpService;
import com.qh.recruit.admin.service.IJobService;
import com.qh.recruit.admin.service.ITagService;
import com.qh.recruit.common.annotation.Log;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.common.enums.BusinessType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/etp")
public class EnterpriseController extends BaseController {

    @Resource
    private IJobService jobService;
    @Resource
    private ICategoryService categoryService;
    @Resource
    private ITagService tagService;
    @Autowired
    private IEtpService etpService;
    @GetMapping("/list")
    public TableDataInfo list(Etp etp)
    {
        startPage();
        List<Etp> list = etpService.selectEtpList(etp);
        return getDataTable(list);
    }

    @GetMapping("/job/list")
    public TableDataInfo jobList(Job job)
    {
        startPage();
        List<Job> list = jobService.selectJobList(job);
        return getDataTable(list);
    }

    /**
     * 获取岗位详细信息
     */
    @GetMapping("/job/{id}")
    public AjaxResult getJobInfo(@PathVariable("id") Long id)
    {
        return success(jobService.selectJobById(id));
    }

    /**
     * 新增岗位
     */
    @Log(title = "岗位", businessType = BusinessType.INSERT)
    @PostMapping("/job")
    public AjaxResult addJob(@RequestBody Job job)
    {
        return toAjax(jobService.insertJob(job));
    }

    /**
     * 修改岗位
     */
    @Log(title = "岗位", businessType = BusinessType.UPDATE)
    @PutMapping("/job")
    public AjaxResult editJob(@RequestBody Job job)
    {
        return toAjax(jobService.updateJob(job));
    }

    /**
     * 删除岗位
     */
    @Log(title = "岗位", businessType = BusinessType.DELETE)
    @DeleteMapping("/job/{ids}")
    public AjaxResult removeJob(@PathVariable Long[] ids)
    {
        return toAjax(jobService.deleteJobByIds(ids));
    }

    /**
     * 查询分类管理列表
     */
    @GetMapping("/category/list")
    public TableDataInfo categoryList(Category category)
    {
        List<Category> list = categoryService.selectCategoryList(category);
        return getDataTable(list);
    }

    /**
     * 获取分类管理详细信息
     */
    @GetMapping("/category/{id}")
    public AjaxResult getCategoryInfo(@PathVariable("id") Long id)
    {
        return success(categoryService.selectCategoryById(id));
    }

    /**
     * 查询标签管理列表
     */
    @GetMapping("/tag/list")
    public TableDataInfo tagList(Tag tag)
    {
        List<Tag> list = tagService.selectTagList(tag);
        return getDataTable(list);
    }

    /**
     * 获取标签管理详细信息
     */
    @GetMapping("/tag/{id}")
    public AjaxResult getTagInfo(@PathVariable("id") Long id)
    {
        return success(tagService.selectTagById(id));
    }

}
