package com.hryen.blog.model;

// 分页
public class Pagination {

    // 当前页码
    private Integer PageNumber;

    // 大小
    private Integer pageSize;

    // 数据库开始索引
    private Integer startIndex;

    // 总记录数
    private Integer totalRecord;

    // 总页数
    private Integer totalPage;

    public Pagination(Integer pageNumber, Integer pageSize, Integer totalRecord) {
        PageNumber = pageNumber;
        this.pageSize = pageSize;
        this.totalRecord = totalRecord;
        this.startIndex = (pageNumber-1)*pageSize;
        this.totalPage = totalRecord%pageSize==0?totalRecord/pageSize:totalRecord/pageSize+1;
    }

    public Integer getPageNumber() {
        return PageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        PageNumber = pageNumber;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(Integer startIndex) {
        this.startIndex = startIndex;
    }

    public Integer getTotalRecord() {
        return totalRecord;
    }

    public void setTotalRecord(Integer totalRecord) {
        this.totalRecord = totalRecord;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    @Override
    public String toString() {
        return "Pagination{" +
                "PageNumber=" + PageNumber +
                ", pageSize=" + pageSize +
                ", startIndex=" + startIndex +
                ", totalRecord=" + totalRecord +
                ", totalPage=" + totalPage +
                '}';
    }
}