package com.hryen.blog.service;

import com.hryen.blog.util.RedisUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.hryen.blog.mapper.SysConfigMapper;

import java.util.concurrent.TimeUnit;

@Service
public class SysConfigService {

    @Autowired
    private SysConfigMapper sysConfigMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private RedisUtils redisUtils;

    private final String keysPrefix = "blog_sysconfig_";

//    public String getBlogTitle() {
//        String blogTitle = stringRedisTemplate.boundValueOps(keysPrefix + "blog.title").get();
//        if (null == blogTitle) {
//            blogTitle = sysConfigMapper.getSysConfig("blog.title");
//            stringRedisTemplate.boundValueOps(keysPrefix + "blog.title").set(blogTitle, 7L, TimeUnit.DAYS);
//        }
//        return blogTitle;
//    }

    @Cacheable(value = "blog_sysconfig_"+"blog.title")
    public String getBlogTitle() {
        return sysConfigMapper.getSysConfig("blog.title");
    }

    public String getBlogDescription() {
        String blogDescription = stringRedisTemplate.boundValueOps(keysPrefix + "blog.description").get();
        if (null == blogDescription) {
            blogDescription = sysConfigMapper.getSysConfig("blog.description");
            stringRedisTemplate.boundValueOps(keysPrefix + "blog.description").set(blogDescription, 7L, TimeUnit.DAYS);
        }
        return blogDescription;
    }

    public String getIndexPageSize() {
        String indexPageSize = stringRedisTemplate.boundValueOps(keysPrefix + "index.page.size").get();
        if (null == indexPageSize) {
            indexPageSize = sysConfigMapper.getSysConfig("index.page.size");
            stringRedisTemplate.boundValueOps(keysPrefix + "index.page.size").set(indexPageSize, 7L, TimeUnit.DAYS);
        }
        return indexPageSize;
    }

    public void updateBlogTitle(String title) {
        sysConfigMapper.updateSysConfig("blog.title", title);
        redisUtils.delKeys(keysPrefix + "blog.title");
    }

    public void updateBlogDescription(String description) {
        sysConfigMapper.updateSysConfig("blog.description", description);
        redisUtils.delKeys(keysPrefix + "blog.description");
    }

    public void updateIndexPageSize(Integer size) {
        sysConfigMapper.updateSysConfig("index.page.size", String.valueOf(size));
        redisUtils.delKeys(keysPrefix + "index.page.size");
    }

}
