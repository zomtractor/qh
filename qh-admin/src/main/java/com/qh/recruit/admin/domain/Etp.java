package com.qh.recruit.admin.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;

/**
 * 企业管理对象 tb_etp
 * 
 * @author ruoyi
 * @date 2025-04-26
 */
public class Etp extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** todo */
    @Excel(name = "todo")
    private Long userId;

    /** todo */
    @Excel(name = "todo")
    private String logoFileId;

    /** 企业名称 */
    @Excel(name = "企业名称")
    private String name;

    /** 宣传信息 */
    @Excel(name = "宣传信息")
    private String description;

    /** 法人 */
    @Excel(name = "法人")
    private String legalPerson;

    /** 地址 */
    @Excel(name = "地址")
    private String address;

    /** 电话 */
    @Excel(name = "电话")
    private String phone;

    /** 电子邮件 */
    @Excel(name = "电子邮件")
    private String email;

    /** 官网 */
    @Excel(name = "官网")
    private String website;

    /** 企业热度 */
    @Excel(name = "企业热度")
    private Long popularity;

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

    public void setLogoFileId(String logoFileId) 
    {
        this.logoFileId = logoFileId;
    }

    public String getLogoFileId() 
    {
        return logoFileId;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setLegalPerson(String legalPerson) 
    {
        this.legalPerson = legalPerson;
    }

    public String getLegalPerson() 
    {
        return legalPerson;
    }

    public void setAddress(String address) 
    {
        this.address = address;
    }

    public String getAddress() 
    {
        return address;
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

    public void setWebsite(String website) 
    {
        this.website = website;
    }

    public String getWebsite() 
    {
        return website;
    }

    public void setPopularity(Long popularity) 
    {
        this.popularity = popularity;
    }

    public Long getPopularity() 
    {
        return popularity;
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
            .append("logoFileId", getLogoFileId())
            .append("name", getName())
            .append("description", getDescription())
            .append("legalPerson", getLegalPerson())
            .append("address", getAddress())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("website", getWebsite())
            .append("popularity", getPopularity())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("status", getStatus())
            .append("version", getVersion())
            .toString();
    }
}
