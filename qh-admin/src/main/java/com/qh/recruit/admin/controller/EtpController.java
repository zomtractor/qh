package com.qh.recruit.admin.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import javax.annotation.Resource;
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
import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.service.IEtpService;
import com.qh.recruit.common.utils.poi.ExcelUtil;
import com.qh.recruit.common.core.page.TableDataInfo;

/**
 * 企业管理Controller
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
@RestController
@RequestMapping("/admin/etp")
public class EtpController extends BaseController
{
    @Resource
    private IEtpService etpService;

    /**
     * 查询企业管理列表
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:list')")
    @GetMapping("/list")
    public TableDataInfo list(Etp etp)
    {
        startPage();
        List<Etp> list = etpService.selectEtpList(etp);
        return getDataTable(list);
    }

    /**
     * 导出企业管理列表
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:export')")
    @Log(title = "企业管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Etp etp)
    {
        List<Etp> list = etpService.selectEtpList(etp);
        ExcelUtil<Etp> util = new ExcelUtil<Etp>(Etp.class);
        util.exportExcel(response, list, "企业管理数据");
    }

    /**
     * 获取企业管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(etpService.selectEtpById(id));
    }

    /**
     * 新增企业管理
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:add')")
    @Log(title = "企业管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Etp etp)
    {
        return toAjax(etpService.insertEtp(etp));
    }

    /**
     * 修改企业管理
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:edit')")
    @Log(title = "企业管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Etp etp)
    {
        return toAjax(etpService.updateEtp(etp));
    }

    /**
     * 删除企业管理
     */
    @PreAuthorize("@ss.hasPermi('admin:etp:remove')")
    @Log(title = "企业管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(etpService.deleteEtpByIds(ids));
    }
}
