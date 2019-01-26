package com.hryen.blog.mapper;

import com.hryen.blog.model.Category;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;

import java.util.List;

@Mapper
public interface CategoryMapper {

    // 1.获取所有分类
    @Select("SELECT * FROM category")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.countArticleTotalRecordByCategoryName", fetchType = FetchType.LAZY))
    })
    List<Category> listAllCategory();

}
