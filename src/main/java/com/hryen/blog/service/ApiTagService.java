package com.hryen.blog.service;

import com.hryen.blog.mapper.TagMapper;
import com.hryen.blog.model.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApiTagService {

    @Autowired
    private TagMapper tagMapper;

    // 1.获取所有标签
    public List<Tag> listAllTag() {
        return tagMapper.listAllTag();
    }

}
