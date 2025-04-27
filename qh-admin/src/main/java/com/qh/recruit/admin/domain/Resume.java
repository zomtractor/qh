package com.qh.recruit.admin.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;

/**
 * 简历对象 tb_resume
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public class Resume extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long userId;

    /** 头像文件ID */
    @Excel(name = "头像文件ID")
    private String avatarFileId;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 年龄 */
    @Excel(name = "年龄")
    private Long age;

    /** 教育经历 */
    @Excel(name = "教育经历")
    private String education;

    /** 毕业院校 */
    @Excel(name = "毕业院校")
    private String school;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 电子邮件 */
    @Excel(name = "电子邮件")
    private String email;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String jobIntention;

    /** 简历附件 */
    @Excel(name = "简历附件")
    private String attachmentFileIds;

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

    public void setAvatarFileId(String avatarFileId) 
    {
        this.avatarFileId = avatarFileId;
    }

    public String getAvatarFileId() 
    {
        return avatarFileId;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setGender(String gender) 
    {
        this.gender = gender;
    }

    public String getGender() 
    {
        return gender;
    }

    public void setAge(Long age) 
    {
        this.age = age;
    }

    public Long getAge() 
    {
        return age;
    }

    public void setEducation(String education) 
    {
        this.education = education;
    }

    public String getEducation() 
    {
        return education;
    }

    public void setSchool(String school) 
    {
        this.school = school;
    }

    public String getSchool() 
    {
        return school;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setJobIntention(String jobIntention) 
    {
        this.jobIntention = jobIntention;
    }

    public String getJobIntention() 
    {
        return jobIntention;
    }

    public void setAttachmentFileIds(String attachmentFileIds) 
    {
        this.attachmentFileIds = attachmentFileIds;
    }

    public String getAttachmentFileIds() 
    {
        return attachmentFileIds;
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
            .append("avatarFileId", getAvatarFileId())
            .append("name", getName())
            .append("gender", getGender())
            .append("age", getAge())
            .append("education", getEducation())
            .append("school", getSchool())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("jobIntention", getJobIntention())
            .append("attachmentFileIds", getAttachmentFileIds())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("status", getStatus())
            .append("version", getVersion())
            .toString();
    }
}
