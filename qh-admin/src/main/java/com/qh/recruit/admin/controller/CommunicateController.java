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
import com.qh.recruit.admin.domain.Communicate;
import com.qh.recruit.admin.service.ICommunicateService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 沟通Controller
 * 
 * @author ruoyi
 * @date 2025-05-02
 */
@RestController
@RequestMapping("/admin/communicate")
public class CommunicateController extends BaseController
{
    @Autowired
    private ICommunicateService communicateService;

    /**
     * 查询沟通列表
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:list')")
    @GetMapping("/list")
    public TableDataInfo list(Communicate communicate)
    {
        startPage();
        List<Communicate> list = communicateService.selectCommunicateList(communicate);
        return getDataTable(list);
    }

    /**
     * 导出沟通列表
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:export')")
    @Log(title = "沟通", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Communicate communicate)
    {
        List<Communicate> list = communicateService.selectCommunicateList(communicate);
        ExcelUtil<Communicate> util = new ExcelUtil<Communicate>(Communicate.class);
        util.exportExcel(response, list, "沟通数据");
    }

    /**
     * 获取沟通详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(communicateService.selectCommunicateById(id));
    }

    /**
     * 新增沟通
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:add')")
    @Log(title = "沟通", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Communicate communicate)
    {
        return toAjax(communicateService.insertCommunicate(communicate));
    }

    /**
     * 修改沟通
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:edit')")
    @Log(title = "沟通", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Communicate communicate)
    {
        return toAjax(communicateService.updateCommunicate(communicate));
    }

    /**
     * 删除沟通
     */
    @PreAuthorize("@ss.hasPermi('admin:communicate:remove')")
    @Log(title = "沟通", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(communicateService.deleteCommunicateByIds(ids));
    }
}
