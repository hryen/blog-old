package com.hryen.blog.service;

import com.hryen.blog.mapper.CommonMapper;
import com.hryen.blog.model.Navigation;
import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ApiNavigationService {

    @Autowired
    private Snowflake snowflake;

    @Autowired
    private CommonMapper commonMapper;

    @Autowired
    private ApiCacheService apiCacheService;

    @Transactional
    public void save(Navigation navigation) {
        // set id
        long id = snowflake.nextId();
        navigation.setId(String.valueOf(id));
        // save
        commonMapper.saveNavigation(navigation);
        // clean cache
        apiCacheService.cleanBlogSysConfigCache();
    }

    @Transactional
    public void update(Navigation navigation) {
        // update
        commonMapper.updateNavigation(navigation);
        // clean cache
        apiCacheService.cleanBlogSysConfigCache();
    }

    @Transactional
    public void delete(Navigation navigation) {
        // delete
        commonMapper.deleteNavigation(navigation.getId());
        // clean cache
        apiCacheService.cleanBlogSysConfigCache();
    }

}
