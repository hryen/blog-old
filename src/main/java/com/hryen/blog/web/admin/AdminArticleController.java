package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/article")
public class AdminArticleController {

    // 1.所有文章页面
    @GetMapping("/list")
    public String getArticleList() {
        return "admin/article-list";
    }

    // 2.新建文章页面
    @GetMapping("/new")
    public String getArticleNew() {
        return "admin/article-new";
    }

    // 3.回收站页面
    @GetMapping("/trash")
    public String getArticleTrash() {
        return "admin/article-trash";
    }

}
