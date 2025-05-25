package com.qh.recruit.user.domain.Dto;


import com.qh.recruit.admin.domain.Category;
import com.qh.recruit.admin.domain.Tag;
import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;
import com.qh.recruit.user.domain.UserJob;

import java.util.List;

public class UserJobDto extends UserJob
{
    private String etpName;
    private List<Category> categoryList;
    private List<Tag> tagList;
    private Integer salaryLowerBound;
    private Integer salaryUpperBound;
    private String keywords;

    public String getEtpName() {
        return etpName;
    }

    public void setEtpName(String etpName) {
        this.etpName = etpName;
    }

    public List<Category> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<Category> categoryList) {
        this.categoryList = categoryList;
    }

    public List<Tag> getTagList() {
        return tagList;
    }

    public void setTagList(List<Tag> tagList) {
        this.tagList = tagList;
    }

    public Integer getSalaryUpperBound() {
        return salaryUpperBound;
    }

    public void setSalaryUpperBound(Integer salaryUpperBound) {
        this.salaryUpperBound = salaryUpperBound;
    }

    public Integer getSalaryLowerBound() {
        return salaryLowerBound;
    }

    public void setSalaryLowerBound(Integer salaryLowerBound) {
        this.salaryLowerBound = salaryLowerBound;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }
}

