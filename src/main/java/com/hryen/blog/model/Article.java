package com.hryen.blog.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

// 文章数据模型
public class Article implements Serializable {

    private static final long serialVersionUID = -7719945875265102343L;

    // id
    private String id;

    // 类型
    private String type;

    // 标题
    private String title;

    // 发布日期
    private Date publishDate;

    // 最后修改日期
    private Date lastModifiedDate;

    // 分类
    private String categoryName;

    // 标签
    private List<Tag> tagList;

    // 描述
    private String summary;

    // markdown格式内容
    private String markdownContent;

    // html格式内容
    private String htmlContent;

    // 状态 0正常 1隐藏 2置顶
    private Character status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate(Date lastModifiedDate) {
        this.lastModifiedDate = lastModifiedDate;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<Tag> getTagList() {
        return tagList;
    }

    public void setTagList(List<Tag> tagList) {
        this.tagList = tagList;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getMarkdownContent() {
        return markdownContent;
    }

    public void setMarkdownContent(String markdownContent) {
        this.markdownContent = markdownContent;
    }

    public String getHtmlContent() {
        return htmlContent;
    }

    public void setHtmlContent(String htmlContent) {
        this.htmlContent = htmlContent;
    }

    public Character getStatus() {
        return status;
    }

    public void setStatus(Character status) {
        this.status = status;
    }
}
