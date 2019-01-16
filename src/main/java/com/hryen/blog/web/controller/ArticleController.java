package com.hryen.blog.web.controller;

import com.hryen.blog.model.Article;
import com.hryen.blog.service.ArticleService;
import com.hryen.blog.util.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.Map;

@Controller
@RequestMapping("/article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private ControllerUtils controllerUtils;

    @GetMapping("/{id}")
    public String getArticleByArticleId(@PathVariable("id") String articleId, Model model) {

        Article article = articleService.getArticleByArticleId(articleId);

        // 如果文章不存在或被隐藏 返回404
        if (null == article || '1' == article.getStatus()) {
            return "error/404";
        }

        // 获取博客的 标题，描述，导航，所属者
        Map<String, Object> commonAttributes = controllerUtils.getCommonAttributes();

        model.addAttribute("article", article);
        model.addAllAttributes(commonAttributes);

        return "article";
    }

}
