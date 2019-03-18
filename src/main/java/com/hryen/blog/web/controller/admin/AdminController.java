package com.hryen.blog.web.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // 1.1 redirect to /admin/index
    @GetMapping("")
    public String redirectAdminIndex() {
        return "redirect:/admin/index";
    }

    // 1.2 admin index
    @GetMapping("/index")
    public String getAdminIndex(HttpServletRequest request, Model model) {
        Object user = request.getSession().getAttribute("user");
        model.addAttribute("user", user);
        return "admin/index";
    }

    // 2.1 article new
    @GetMapping("/article/new")
    public String getArticleNew() {
        return "admin/article-new-edit";
    }

    // 2.2 article list
    @GetMapping("/article/list")
    public String getArticleList() {
        return "admin/article-list";
    }

    // 2.3 article trash
    @GetMapping("/article/trash")
    public String getArticleTrash() {
        return "admin/article-trash";
    }

    // 2.4 article edit
    @GetMapping("/article/edit/{articleId}")
    public String getArticleEdit(@PathVariable("articleId") String articleId, Model model) {
        model.addAttribute("articleId", articleId);
        model.addAttribute("isEdit", true);
        return "admin/article-new-edit";
    }

    // 3 comments
    @GetMapping("/comments")
    public String getAdminComments() {
        return "admin/comments";
    }

    // 4 attachments
    @GetMapping("/attachments")
    public String getAdminUploads() {
        return "admin/attachments";
    }

    // 5 categories
    @GetMapping("/categories")
    public String getAdminCategories() {
        return "admin/categories";
    }

    // 6 settings
    @GetMapping("/settings")
    public String getAdminSettings() {
        return "admin/settings";
    }

}
