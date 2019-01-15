package com.hryen.blog.mapper;

import com.hryen.blog.model.Tag;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface TagMapper {

    // 根据文章id查询所关联的所有标签
    @Select("SELECT * FROM tag WHERE name IN(SELECT tag_name FROM article_tag WHERE article_id=#{articleId})")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getArticleTotalRecordByTagName"))
    })
    List<Tag> getTagsByArticleId(String articleId);














//    // 查询所有标签
//    @Select("SELECT * FROM tag")
//    @Results({
//            @Result(column = "id", property = "id"),
//            @Result(column = "id", property = "articleCount", javaType = Integer.class,
//                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getTotalRecordByTagId"))
//    })
//    List<Tag> getAllTags();
}
