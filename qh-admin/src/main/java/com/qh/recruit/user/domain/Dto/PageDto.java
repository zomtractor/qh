package com.qh.recruit.user.domain.Dto;

public class PageDto {

    private Integer pageNum;

    private Integer pageSize;

    @Override
    public String toString() {
        return "pageDto{" +
                "pageNum=" + pageNum +
                ", pageSize=" + pageSize +
                '}';
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}
