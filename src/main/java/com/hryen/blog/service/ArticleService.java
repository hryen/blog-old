package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.model.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Cacheable(value = "blog_article", key = "#str", unless="#result == null")
    public Article getArticleByArticlePermalinkOrId(String str) {
        return articleMapper.getArticleByArticlePermalinkOrId(str);
    }

}
