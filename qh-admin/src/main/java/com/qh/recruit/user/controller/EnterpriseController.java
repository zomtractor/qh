package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.service.IEtpService;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.page.TableDataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/etp")
public class EnterpriseController  extends BaseController {
    @Autowired
    private IEtpService etpService;
    @GetMapping("/list")
    public TableDataInfo list(Etp etp)
    {
        startPage();
        List<Etp> list = etpService.selectEtpList(etp);
        return getDataTable(list);
    }
}
