package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.model.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Cacheable(value = "blog_article", key = "#articleId")
    public Article getArticleByArticleId(String articleId) {
        return articleMapper.getArticleByArticleId(articleId);
    }

}
