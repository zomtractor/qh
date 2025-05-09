package com.qh.recruit.admin.domain.dto;

import com.qh.recruit.admin.domain.Interview;

public class InterviewDto extends Interview {
    private static final long serialVersionUID = 1L;

    /** 用户名 */
    private String userName;

    /** 职位名称 */
    private String jobName;

    /** 企业名称 */
    private String etpName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getJobName() {
        return jobName;
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
