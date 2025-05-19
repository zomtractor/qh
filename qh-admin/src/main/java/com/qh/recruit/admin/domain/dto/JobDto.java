package com.qh.recruit.admin.domain.dto;

import com.qh.recruit.admin.domain.Category;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.domain.Tag;

import java.util.List;

public class JobDto extends Job {
    private String etpName;
    private List<Category> categoryList;
    private List<Tag> tagList;

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
}
