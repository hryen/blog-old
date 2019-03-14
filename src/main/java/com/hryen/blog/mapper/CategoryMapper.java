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

    // 3.save
    @Insert("INSERT INTO `category`(`id`, `name`, `description`) VALUES (#{cate.id}, #{cate.name}, #{cate.description})")
    void save(@Param("cate") Category cate);

    // 4.update
    @Update("UPDATE `category` SET `name` = #{cate.name}, `description` = #{cate.description} WHERE `id` = #{cate.id}")
    void update(@Param("cate") Category cate);

    // 5.delete
    @Delete("DELETE FROM `category` WHERE `id` = #{id}")
    void delete(String id);

    // 6.将该分类下的文章的分类设置成未分类
    @Update("UPDATE `article` SET `category_id`='1'" +
            "WHERE `id` IN(SELECT `id` FROM(SELECT `id` FROM `article` WHERE `category_id`=#{categoryId}) as a)")
    void updateArticleCategoryToDefault(String categoryId);
}
