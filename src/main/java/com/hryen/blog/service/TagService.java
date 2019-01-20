package com.hryen.blog.service;

import com.hryen.blog.mapper.TagMapper;
import com.hryen.blog.model.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;

    public List<Tag> getAllTags() {
        return tagMapper.getAllTags();
    }

}
