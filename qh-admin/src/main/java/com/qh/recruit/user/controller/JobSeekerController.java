package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.dto.InterviewDto;
import com.qh.recruit.admin.service.IInterviewService;
import com.qh.recruit.admin.service.IUserService;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.Dto.PageDto;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.service.ResumeUserService;
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
    @Autowired
    ResumeUserService resumeuserService;

    @GetMapping("/list")
    public TableDataInfo getJobList(@RequestParam(required = false,defaultValue = "5") int pageSize) {
        List<UserJob> list=userJobService.getJobList(pageSize);
        TableDataInfo tableDataInfo=new TableDataInfo();
        tableDataInfo.setRows(list);
        tableDataInfo.setTotal(userJobService.findTotal());
        return tableDataInfo;
    }

    @PostMapping("/page")
    public TableDataInfo getPageList(@RequestBody PageDto pageDto){
        List<UserJob> list=userJobService.getPageList((pageDto.getPageNum()-1)*pageDto.getPageSize(),pageDto.getPageSize());
        TableDataInfo tableDataInfo=new TableDataInfo();
        tableDataInfo.setRows(list);
        tableDataInfo.setTotal(userJobService.findTotal());
        return tableDataInfo;
    }

    @GetMapping("/userList")
    public TableDataInfo getUserList() {
        startPage();

        return getDataTable(userService.selectUserList(null));
    }

    @GetMapping("/search")
    public TableDataInfo search(@RequestParam(value = "keyword",defaultValue = "all") String keyword){
        if(keyword.equals("all")){
            return getDataTable(userJobService.getJobList(5));
        }
        return getDataTable(userJobService.getSearchJobList(keyword));
    }

    @PostMapping("/confirm")
    public TableDataInfo confirm(@RequestBody UserJobDto userJobDto) {
        return getDataTable(userJobService.confirm(userJobDto.getCity(), userJobDto.getIndustry(),userJobDto.getSalary()));
    }

    @PostMapping("/get_info")
    public AjaxResult getUserInfo(@RequestParam("user_id")Long userId) {
        return resumeuserService.getUserInfoByUserId(userId);
    }

    @PostMapping("/updateUserInfo")
    public AjaxResult updateUserInfo(@RequestBody ResumeJob userInfo) {
        return resumeuserService.updateResumeInfo(userInfo);
    }

    @PostMapping("/getInterviewInfo")
    public AjaxResult getInterviewInfo(@RequestBody Interview interview) {
//        return resumeuserService.updateResumeInfo(userInfo);
        return resumeuserService.getInterviewInfo(interview);
//        return null;
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
