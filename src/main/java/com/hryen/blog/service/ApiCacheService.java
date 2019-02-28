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
        deleteKeysWithPattern("blog_index::articleList*");
        logger.info("Clean index article list cache");
    }

    // 2.清除所有文章缓存
    public void cleanArticleCache() {
        deleteKeysWithPattern("blog_article*");
        logger.info("Clean articles cache");
    }

    // 3.清除所有博客设置缓存
    public void cleanBlogSysConfigCache() {
        deleteKeysWithPattern("blog_sys.config*");
        stringRedisTemplate.delete("blog_common::navigationList");
        logger.info("Clean blog sysconfig cache");
    }

    // 根据key的名称pattern删除keys
    private void deleteKeysWithPattern(String pattern) {
        Set<String> keys = stringRedisTemplate.keys(pattern);
        stringRedisTemplate.delete(keys);
    }

}
