package com.hryen.blog.service;

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

    // 1.清除首页文章缓存
    public void cleanIndexArticleListCache() {
        stringRedisTemplate.delete("blog_index::articleList");
        logger.info("Clean index articles list cache");
    }

    // 2.清除所有文章缓存
    public void cleanArticleCache() {
        Set<String> keys = stringRedisTemplate.keys("blog_article*");
        stringRedisTemplate.delete(keys);
        logger.info("Clean articles cache");
    }

    // 3.清除所有博客设置缓存
    public void cleanBlogSysConfigCache() {
        Set<String> keys = stringRedisTemplate.keys("blog_sys.config*");
        keys.add("blog_common::navigationList");
        stringRedisTemplate.delete(keys);
        logger.info("Clean blog sysconfig cache");
    }

}
