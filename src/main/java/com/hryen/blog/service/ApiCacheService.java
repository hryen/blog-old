package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.model.Article;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class ApiCacheService {

    private Logger logger = LoggerFactory.getLogger(ApiCacheService.class);

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private ArticleMapper articleMapper;

    // 1.清除首页文章缓存
    public void cleanIndexArticleListCache() {
        deleteKeysWithPattern("blog_index::articleList*");
    }

    // 2.清除所有文章缓存
    public void cleanArticleCache() {
        deleteKeysWithPattern("blog_article*");
    }

    // 2.1.按 文章id 或 固定链接 清除文章缓存
    public void cleanArticleCache(String str) {
        Article article = articleMapper.getArticleByArticlePermalinkOrId(str);
        if (null != article) {
            stringRedisTemplate.delete("blog_article::" + article.getId());

            String permalink = article.getPermalink();
            if (null != permalink) {
                stringRedisTemplate.delete("blog_article::" + permalink);
            }
        }
    }

    // 3.清除所有博客设置缓存
    public void cleanBlogSysConfigCache() {
        deleteKeysWithPattern("blog_sys.config*");
        stringRedisTemplate.delete("blog_common::navigationList");
    }

    // 根据key的名称pattern删除keys
    private void deleteKeysWithPattern(String pattern) {
        Set<String> keys = stringRedisTemplate.keys(pattern);
        stringRedisTemplate.delete(keys);
    }

}
