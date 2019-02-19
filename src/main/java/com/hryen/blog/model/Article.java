package com.hryen.blog.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

// 文章数据模型
public class Article implements Serializable {

    private static final long serialVersionUID = -7719945875265102343L;

    // id
    private String id;

    // 标题
    private String title;

    // 固定链接
    private String permalink;

    // 发布日期
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishDate;

    // 最后修改日期
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
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

    // 状态 0已发布 1已隐藏 2已置顶 3已删除
    private Character status;

    // 是否允许评论
    private boolean commentStatus;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPermalink() {
        return permalink;
    }

    public void setPermalink(String permalink) {
        this.permalink = permalink;
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

    public boolean isCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(boolean commentStatus) {
        this.commentStatus = commentStatus;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", permalink='" + permalink + '\'' +
                ", publishDate=" + publishDate +
                ", lastModifiedDate=" + lastModifiedDate +
                ", categoryName='" + categoryName + '\'' +
                ", tagList=" + tagList +
                ", summary='" + summary + '\'' +
                ", markdownContent='" + markdownContent + '\'' +
                ", htmlContent='" + htmlContent + '\'' +
                ", status=" + status +
                ", commentStatus=" + commentStatus +
                '}';
    }
}
