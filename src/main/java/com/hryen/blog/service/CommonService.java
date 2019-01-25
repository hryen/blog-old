package com.hryen.blog.service;

import com.hryen.blog.mapper.CommonMapper;
import com.hryen.blog.model.Navigation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommonService {

    private final String SYS_CONFIG_CACHE_PREFIX = "blog_sys.config";

    @Autowired
    private CommonMapper commonMapper;

    // 博客标题
    @Cacheable(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.title'", unless="#result == null")
    public String getBlogTitle() {
        return commonMapper.getSysConfig("blog.title");
    }

    // 博客描述
    @Cacheable(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.description'", unless="#result == null")
    public String getBlogDescription() {
        return commonMapper.getSysConfig("blog.description");
    }

    // 首页size
    @Cacheable(value = SYS_CONFIG_CACHE_PREFIX, key = "'index.page.size'", unless="#result == null")
    public Integer getIndexPageSize() {
        return Integer.valueOf(commonMapper.getSysConfig("index.page.size"));
    }

    // 博客所属
    @Cacheable(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.owner'", unless="#result == null")
    public String getBlogOwner() {
        return commonMapper.getSysConfig("blog.owner");
    }

    // 更新博客标题
    @CacheEvict(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.title'")
    @Transactional
    public void updateBlogTitle(String title) {
        commonMapper.updateSysConfig("blog.title", title);
    }


    // 更新博客描述
    @CacheEvict(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.description'")
    @Transactional
    public void updateBlogDescription(String description) {
        commonMapper.updateSysConfig("blog.description", description);
    }

    // 更新首页size
    @CacheEvict(value = SYS_CONFIG_CACHE_PREFIX, key = "'index.page.size'")
    @Transactional
    public void updateIndexPageSize(Integer size) {
        commonMapper.updateSysConfig("index.page.size", String.valueOf(size));
    }

    // 更新博客所属
    @CacheEvict(value = SYS_CONFIG_CACHE_PREFIX, key = "'blog.owner'")
    @Transactional
    public void updateBlogOwner(String owner) {
        commonMapper.updateSysConfig("blog.owner", owner);
    }

    // 获取导航list
    @Cacheable(value = "blog_common", key = "'navigationList'", unless="#result == null")
    public List<Navigation> getNavigation() {
        return commonMapper.getNavigations();
    }

}
