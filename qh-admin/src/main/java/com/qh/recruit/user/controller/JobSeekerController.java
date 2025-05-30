package com.qh.recruit.user.controller;

import com.qh.recruit.admin.domain.Etp;
import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.Resume;
import com.qh.recruit.admin.domain.dto.InterviewDto;
import com.qh.recruit.admin.service.IInterviewService;
import com.qh.recruit.admin.service.IJobService;
import com.qh.recruit.admin.service.IResumeService;
import com.qh.recruit.admin.service.IUserService;
import com.qh.recruit.common.core.controller.BaseController;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.Dto.PageDto;
import com.qh.recruit.user.domain.Dto.UserJobDto;
import com.qh.recruit.user.domain.ResumeJob;
import com.qh.recruit.user.domain.UserJob;
import com.qh.recruit.user.service.JobSeekerService;
import com.qh.recruit.user.service.ResumeUserService;
import com.qh.recruit.user.service.UserJobService;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
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

    @Resource
    private IResumeService resumeService;

    @Resource
    private JobSeekerService jobSeekerService;

    @GetMapping("/job/list")
    public TableDataInfo getJobList(UserJobDto job) {
        startPage();
        List<UserJobDto> list = userJobService.getJobList(job);
        return getDataTable(list);
    }

    @GetMapping("/job/{id}}")
    public AjaxResult getJobInfo(@PathVariable("id") Long id)
    {
        return success(userJobService.selectJobById(id));
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
    public TableDataInfo search(@RequestParam(value = "keyword",defaultValue = "all") String keyword,Integer pageNum,Integer pageSize){
        if("all".equals(keyword)){
            keyword="";
        }
        TableDataInfo tableDataInfo=new TableDataInfo();
        tableDataInfo.setRows(userJobService.getSearchJobList(keyword,(pageNum-1)*pageSize,pageSize));
        tableDataInfo.setTotal(userJobService.searchJobCount(keyword));
        return tableDataInfo;
    }

    @PostMapping("/confirm")
    public TableDataInfo confirm(@RequestBody UserJobDto userJobDto) {
        TableDataInfo tableDataInfo=new TableDataInfo();
//        tableDataInfo.setRows(userJobService.confirm(userJobDto.getCity(), userJobDto.getIndustry(),userJobDto.getSalary(),
//                (userJobDto.getPageNum()-1)*userJobDto.getPageSize(),userJobDto.getPageSize()));
//        tableDataInfo.setTotal(userJobService.confirmCount(userJobDto.getCity(), userJobDto.getIndustry(),userJobDto.getSalary()));
        return tableDataInfo;
    }

    @PostMapping("/get_info")
    public AjaxResult getUserInfo(@RequestParam("user_id")Long userId) {
        return resumeuserService.getUserInfoByUserId(userId);
//        return success(resumeService.selectResumeById(userId));
    }


    @PostMapping("/get_resumeImgs")
    public AjaxResult getResumeImgs(@RequestParam("user_id")Long userId) {
        return resumeuserService.getResumesImgInfo(userId);
    }

    @PostMapping("/updateUserInfo")
    public AjaxResult updateUserInfo(@RequestBody Resume resume) {
//        return resumeuserService.updateResumeInfo(userInfo);
        return toAjax(resumeService.updateResume(resume));
    }

    @PostMapping("/getInterviewInfo")
    public TableDataInfo getInterviewInfo(Interview interview) {
//        return resumeuserService.updateResumeInfo(userInfo);
        startPage();
        List<InterviewDto> interviewInfo = resumeuserService.getInterviewInfo(interview);
        return getDataTable(interviewInfo);
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

    @GetMapping(value = "/interview/{id}")
    public AjaxResult getInterviewInfo(@PathVariable("id") Long id)
    {
        return success(interviewService.selectInterviewById(id));
    }

    @PostMapping("/contact/{id}")
    public AjaxResult contect(@PathVariable Long id){
        return jobSeekerService.contact(id);
    }


}
