package com.hryen.blog.model;

import java.io.Serializable;

// 标签数据模型
public class Tag implements Serializable {

    private static final long serialVersionUID = -5948299824101039709L;

    // 名称
    private String name;

    // 标签下文章数
    private Integer articleCount;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getArticleCount() {
        return articleCount;
    }

    public void setArticleCount(Integer articleCount) {
        this.articleCount = articleCount;
    }
}
