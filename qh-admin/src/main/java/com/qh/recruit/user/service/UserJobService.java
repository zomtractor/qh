package com.qh.recruit.user.service;

import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.user.domain.UserJob;
import org.apache.xmlbeans.impl.xb.xsdschema.Public;

public interface UserJobService {
    public TableDataInfo getJobList();

    public TableDataInfo getSearchJobList(String keyword);

    public TableDataInfo confirm(String location,String category,String salary);

    public Integer searchCategoryId(String category);

    public int[] salaryBeginAndEnd(String salary);
}