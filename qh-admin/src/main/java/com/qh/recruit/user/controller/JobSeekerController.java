package com.qh.recruit.user.controller;

import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.service.UserJobService;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/jobSeeker")
public class JobSeekerController extends BaseController {

    @Autowired
    UserJobService userJobService;

    @GetMapping("/list")
    public TableDataInfo getJobList() {
        startPage();
        return userJobService.getJobList();
    }

    @GetMapping("/search")
    public TableDataInfo search(@RequestParam(value = "keyword",defaultValue = "all") String keyword){
        if(keyword.equals("all")){
            return userJobService.getJobList();
        }
        return userJobService.getSearchJobList(keyword);
    }

    @PostMapping("/confirm")
    public TableDataInfo confirm(@RequestBody UserJobDto userJobDto) {
        return userJobService.confirm(userJobDto.getCity(), userJobDto.getIndustry(),userJobDto.getSalary() );
    }
}
