package com.qh.recruit.user.domain.Dto;


import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;

public class UserJobDto extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 岗位职责 */
    @Excel(name = "岗位职责")
    private String description;

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    /** todo */
    @Excel(name = "todo")
    private String salary;

    /** 工作地点 */
    @Excel(name = "工作地点")
    private String city;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    @Override
    public String toString() {
        return "UserJobDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", salary='" + salary + '\'' +
                ", city='" + city + '\'' +
                ", requirement='" + requirement + '\'' +
                ", etpId=" + etpId +
                ", categoryIds='" + categoryIds + '\'' +
                ", tagIds='" + tagIds + '\'' +
                ", popularity=" + popularity +
                ", status=" + status +
                ", version=" + version +
                ", industry='" + industry + '\'' +
                '}';
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    /** 要求条件 */
    @Excel(name = "要求条件")
    private String requirement;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long etpId;

    /** todo */
    @Excel(name = "todo")
    private String categoryIds;

    /** 标签ID，以逗号分隔 */
    @Excel(name = "标签ID，以逗号分隔")
    private String tagIds;

    /** 岗位热度 */
    @Excel(name = "岗位热度")
    private Long popularity;

    /** $column.columnComment */
    private Integer status;

    /** $column.columnComment */
    private Long version;

    private String industry;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
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

    public void setRequirement(String requirement)
    {
        this.requirement = requirement;
    }

    public String getRequirement()
    {
        return requirement;
    }

    public void setEtpId(Long etpId)
    {
        this.etpId = etpId;
    }

    public Long getEtpId()
    {
        return etpId;
    }

    public void setCategoryIds(String categoryIds)
    {
        this.categoryIds = categoryIds;
    }

    public String getCategoryIds()
    {
        return categoryIds;
    }

    public void setTagIds(String tagIds)
    {
        this.tagIds = tagIds;
    }

    public String getTagIds()
    {
        return tagIds;
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

}

