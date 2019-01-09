package com.hryen.blog.model;

import java.io.Serializable;

public class Navigation implements Serializable {

    private static final long serialVersionUID = 2132777180894839572L;

    private String title;

    private String url;

    private Integer order;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }
}
