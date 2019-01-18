package com.hryen.blog.web.controller;

import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.service.IndexService;
import com.hryen.blog.util.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;


@Controller
public class IndexController {

    @Autowired
    private ControllerUtils controllerUtils;

    @Autowired
    private IndexService indexService;

    @GetMapping("")
    public String getIndexWithPage(String page, Model model) {

        // 检查参数
        int pageNumber = controllerUtils.checkPage(page);
        // 如果参数非法 跳转到首页
        if (-1 == pageNumber) {
            return "redirect:/";
        }

        // 获取博客的 标题，描述，导航，所属者
        Map<String, Object> commonAttributes = controllerUtils.getCommonAttributes();

        // 获取分页
        Pagination pagination = indexService.getPagination(pageNumber);

        // 获取文章list
        List<Article> articleList = indexService.getIndexWithPage(pageNumber, pagination.getStartIndex());

        model.addAllAttributes(commonAttributes);
        model.addAttribute("pagination", pagination);
        model.addAttribute("articleList", articleList);

        return "index";
    }

}
