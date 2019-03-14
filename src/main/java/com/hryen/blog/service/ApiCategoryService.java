package com.hryen.blog.service;

import com.hryen.blog.mapper.CategoryMapper;
import com.hryen.blog.model.Category;
import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ApiCategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private Snowflake snowflake;


    // 1.获取所有分类
    public List<Category> listAllCategory() {
        return categoryMapper.listAllCategory();
    }

    // 2.save
    @Transactional
    public void save(Category category) {
        long id = snowflake.nextId();
        category.setId(String.valueOf(id));
        categoryMapper.save(category);
    }

    // 3.update
    @Transactional
    public void update(Category category) {
        categoryMapper.update(category);
    }

    // 4.delete
    @Transactional
    public void delete(Category category) throws Exception {

        String categoryId = category.getId();

        // 禁止删除默认分类
        if ("1".equals(categoryId)) throw new Exception("Cannot delete default category");

        // 把原来在这个分类下的文章 分类设置成未分类
        categoryMapper.updateArticleCategoryToDefault(categoryId);

        // 删除分类
        categoryMapper.delete(categoryId);
    }

}
