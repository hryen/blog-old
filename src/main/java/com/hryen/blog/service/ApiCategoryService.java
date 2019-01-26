package com.hryen.blog.service;

import com.hryen.blog.mapper.CategoryMapper;
import com.hryen.blog.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApiCategoryService {

    @Autowired
    private CategoryMapper categoryMapper;


    // 1.获取所有分类
    public List<Category> listAllCategory() {
        return categoryMapper.listAllCategory();
    }

}
