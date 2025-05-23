package com.qh.recruit.admin.domain.dto;

import com.qh.recruit.admin.domain.Interview;
import com.qh.recruit.common.annotation.Excel;



public class InterviewDto extends Interview {
    private static final long serialVersionUID = 1L;

    /** 用户名 */
    private String userName;

    /** 职位名称 */
    private String jobName;

    /** 企业名称 */
    private String etpName;



    /** 岗位职责 */
    @Excel(name = "岗位职责")
    private String description;

    /** 工资 */
    @Excel(name = "工资")
    private String salaryDesc;

    /** 工作地点 */
    @Excel(name = "工作地点")
    private String location;

    /** 要求条件 */
    @Excel(name = "要求条件")
    private String requirement;

    public InterviewDto(Long id, Long jobId, String requirement, String location, String salaryDesc, Long etpId, String name) {

        super();
        this.setId(id);
        this.setJobId(jobId);
        this.requirement = requirement;
        this.location = location;
        this.salaryDesc = salaryDesc;
        this.setEtpId(etpId);
        this.jobName = name;

    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getJobName() {
        return jobName;
    }



    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSalaryDesc() {
        return salaryDesc;
    }

    public void setSalaryDesc(String salaryDesc) {
        this.salaryDesc = salaryDesc;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }


    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getEtpName() {
        return etpName;
    }

    public void setEtpName(String etpName) {
        this.etpName = etpName;
    }
}
