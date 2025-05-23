package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.service.ResumeUserService;
import com.qh.recruit.user.service.UserJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/jobSeeker")
public class JobSeekerController extends BaseController {

    @Autowired
    UserJobService userJobService;
    @Autowired
    ResumeUserService resumeuserService;


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





}
