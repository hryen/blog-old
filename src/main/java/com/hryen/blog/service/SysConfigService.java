package com.hryen.blog.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.hryen.blog.mapper.SysConfigMapper;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.CacheEvict;

@Service
public class SysConfigService {

    @Autowired
    private SysConfigMapper sysConfigMapper;

    private final String SYS_CONFIG_CACHE_VALUE = "sys.config";

    @Cacheable(value = SYS_CONFIG_CACHE_VALUE, key = "'blog.title'")
    public String getBlogTitle() {
        return sysConfigMapper.getSysConfig("blog.title");
    }

    @Cacheable(value = SYS_CONFIG_CACHE_VALUE, key = "'blog.description'")
    public String getBlogDescription() {
        return sysConfigMapper.getSysConfig("blog.description");
    }

    @Cacheable(value = SYS_CONFIG_CACHE_VALUE, key = "'index.page.size'")
    public Integer getIndexPageSize() {
        return Integer.valueOf(sysConfigMapper.getSysConfig("index.page.size"));
    }

    @CacheEvict(value = SYS_CONFIG_CACHE_VALUE, key = "'blog.title'")
    public void updateBlogTitle(String title) {
        sysConfigMapper.updateSysConfig("blog.title", title);
    }

    @CacheEvict(value = SYS_CONFIG_CACHE_VALUE, key = "'blog.description'")
    public void updateBlogDescription(String description) {
        sysConfigMapper.updateSysConfig("blog.description", description);
    }

    @CacheEvict(value = SYS_CONFIG_CACHE_VALUE, key = "'index.page.size'")
    public void updateIndexPageSize(Integer size) {
        sysConfigMapper.updateSysConfig("index.page.size", String.valueOf(size));
    }

}
