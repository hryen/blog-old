package com.hryen.blog.model;

import java.io.Serializable;

// 标签数据模型
public class Tag implements Serializable {

    private static final long serialVersionUID = 8735714477815121701L;

    // 名称
    private String name;

    // 标签下文章数
    private Integer articleCount;

    // 前台标签云css样式 标签级别 1-6
    private Integer level;

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

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

}
