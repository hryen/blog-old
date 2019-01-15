package com.hryen.blog.mapper;

import org.apache.ibatis.annotations.*;
import com.hryen.blog.model.Category;
import java.util.List;

@Mapper
public interface CategoryMapper {

    // 根据分类name查询一个分类
    @Select("SELECT * FROM category WHERE name=#{categoryName}")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getArticleTotalRecordByCategoryName"))
    })
    Category getCategoryByCategoryName(String categoryName);














//    // 查询所有分类
//    @Select("SELECT * FROM category")
//    @Results({
//            @Result(column = "id", property = "id", id = true),
//            @Result(column = "id", property = "articleCount", javaType = Integer.class,
//                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getTotalRecordByCategoryId"))
//    })
//    List<Category> getAllCategorys();
}
