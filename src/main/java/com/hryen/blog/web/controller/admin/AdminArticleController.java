package com.hryen.blog.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/article")
public class AdminArticleController {

    // 1.新建文章页面
    @GetMapping("/new")
    public String getArticleNew() {
        return "admin/article-new-edit";
    }

    // 2.所有文章页面
    @GetMapping("/list")
    public String getArticleList() {
        return "admin/article-list";
    }

    // 3.回收站页面
    @GetMapping("/trash")
    public String getArticleTrash() {
        return "admin/article-trash";
    }

    // 4.编辑文章页面
    @GetMapping("/edit/{articleId}")
    public String getArticleEdit(@PathVariable("articleId") String articleId, Model model) {
        model.addAttribute("articleId", articleId);
        model.addAttribute("isEdit", true);
        return "admin/article-new-edit";
    }

}
