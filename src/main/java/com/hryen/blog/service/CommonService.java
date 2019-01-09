package com.hryen.blog.service;

import com.hryen.blog.mapper.CommonMapper;
import com.hryen.blog.model.Navigation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommonService {

    @Autowired
    private CommonMapper commonMapper;

    @Cacheable(value = "header", key = "'navigation'")
    public List<Navigation> getNavigations() {
        return commonMapper.getNavigations();
    }
}
