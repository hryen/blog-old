package com.hryen.blog.web.controller;

import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.service.TagService;
import com.hryen.blog.util.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/tag")
public class TagController {

    @Autowired
    private ControllerUtils controllerUtils;

    @Autowired
    private TagService tagService;

    @GetMapping("/{tagName}")
    public String getArticlesByTagNameWithPage(@PathVariable("tagName") String tagName, String page, Model model) {

        // 检查参数
        int pageNumber = controllerUtils.checkPage(page);
        // 如果参数非法 跳转到首页
        if (-1 == pageNumber) {
            return "redirect:/";
        }

        // 获取博客的 标题，描述，导航，所属者
        Map<String, Object> commonAttributes = controllerUtils.getCommonAttributes();

        // 获取分页
        Pagination pagination = tagService.getPagination(tagName, pageNumber);

        // 获取文章list
        List<Article> articleList = tagService.getArticlesByTagNameWithPage(tagName, pagination.getStartIndex());

        // 如果该标签下一个文章也没有 返回404
        if (0 == articleList.size()) {
            return "/error/404";
        }

        model.addAllAttributes(commonAttributes);
        model.addAttribute("pagination", pagination);
        model.addAttribute("articleList", articleList);
        model.addAttribute("tagName", tagName);

        return "tag";
    }

}
