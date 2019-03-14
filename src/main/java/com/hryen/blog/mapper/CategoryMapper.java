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
            @Result(column = "id", property = "id", id = true),
            @Result(column = "id", property = "articleCount", javaType = Integer.class,
            one = @One(select = "com.hryen.blog.mapper.ArticleMapper.countArticleTotalRecordByCategoryId",
                    fetchType = FetchType.LAZY))
    })
    List<Category> listAllCategory();

    // 2.根据id获取分类
    @Select("SELECT * FROM category WHERE id=#{id}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "id", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.countArticleTotalRecordByCategoryId",
                            fetchType = FetchType.LAZY))
    })
    Category getCategoryById(String id);

}
