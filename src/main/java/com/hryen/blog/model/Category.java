package com.hryen.blog.model;

import java.io.Serializable;

// 分类数据模型
public class Category implements Serializable {

    private static final long serialVersionUID = -788803066400445194L;

    // id
    private String id;

    // 名称
    private String name;

    // 描述
    private String description;

    // 分类下文章数
    private Integer articleCount;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getArticleCount() {
        return articleCount;
    }

    public void setArticleCount(Integer articleCount) {
        this.articleCount = articleCount;
    }
}
