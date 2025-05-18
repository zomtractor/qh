package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.domain.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/jobSeeker")
public class JobSeekerController {

    @GetMapping
    public AjaxResult method(){
        return AjaxResult.success();
    }
}
