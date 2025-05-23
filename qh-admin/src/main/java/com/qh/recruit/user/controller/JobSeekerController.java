package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.dto.InterviewDto;
import com.qh.recruit.admin.service.IInterviewService;
import com.qh.recruit.admin.service.IUserService;
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
    @Autowired
    private IUserService userService;
    @Autowired
    private IInterviewService interviewService;

    @GetMapping("/list")
    public TableDataInfo getJobList() {
        startPage();
        return userJobService.getJobList();
    }
    @GetMapping("/userList")
    public TableDataInfo getUserList() {
        startPage();

        return getDataTable(userService.selectUserList(null));
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

    @PostMapping("/addInterview")
    public AjaxResult addInterview(@RequestBody Interview interview)
    {
        return toAjax(interviewService.insertInterview(interview));
    }

    @GetMapping("/interviewList")
    public TableDataInfo interviewList(InterviewDto interview)
    {
        startPage();
        List<InterviewDto> list = interviewService.selectInterviewDtoList(interview);
        return getDataTable(list);
    }

    @PutMapping("/editInterview")
    public AjaxResult editInterview(@RequestBody Interview interview)
    {
        return toAjax(interviewService.updateInterview(interview));
    }
}
