package com.qh.recruit.admin.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;

/**
 * 面试对象 tb_interview
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public class Interview extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** todo */
    @Excel(name = "todo")
    private Long userId;

    /** todo */
    @Excel(name = "todo")
    private Long jobId;

    /** todo */
    @Excel(name = "todo")
    private Long etpId;

    /** 面试状态 */
    @Excel(name = "面试状态")
    private String interviewStatus;

    /** 消息 */
    @Excel(name = "消息")
    private String message;

    /** 面试时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "面试时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date time;

    /** $column.columnComment */
    private Integer status;

    /** $column.columnComment */
    private Long version;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setJobId(Long jobId) 
    {
        this.jobId = jobId;
    }

    public Long getJobId() 
    {
        return jobId;
    }

    public void setEtpId(Long etpId) 
    {
        this.etpId = etpId;
    }

    public Long getEtpId() 
    {
        return etpId;
    }

    public void setInterviewStatus(String interviewStatus) 
    {
        this.interviewStatus = interviewStatus;
    }

    public String getInterviewStatus() 
    {
        return interviewStatus;
    }

    public void setMessage(String message) 
    {
        this.message = message;
    }

    public String getMessage() 
    {
        return message;
    }

    public void setTime(Date time) 
    {
        this.time = time;
    }

    public Date getTime() 
    {
        return time;
    }

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public void setVersion(Long version) 
    {
        this.version = version;
    }

    public Long getVersion() 
    {
        return version;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("jobId", getJobId())
            .append("etpId", getEtpId())
            .append("interviewStatus", getInterviewStatus())
            .append("message", getMessage())
            .append("time", getTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("status", getStatus())
            .append("version", getVersion())
            .toString();
    }
}
