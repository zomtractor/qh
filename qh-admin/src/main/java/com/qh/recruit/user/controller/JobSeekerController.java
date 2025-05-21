package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/jobSeeker")
public class JobSeekerController extends BaseController {



    @PostMapping("all")
    public AjaxResult all() {
        return AjaxResult.success();
    }
}
