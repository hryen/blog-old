package com.hryen.blog.mapper;

import com.hryen.blog.model.Tag;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;

import java.util.List;

@Mapper
public interface TagMapper {

    // 1.查询所有标签
    @Select("SELECT * FROM tag")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.countArticleTotalRecordByTagName"))
    })
    List<Tag> listAllTag();

    // 1.查询所有标签
    @Select("SELECT * FROM tag")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getArticleTotalRecordByTagName"))
    })
    List<Tag> getAllTags();

    // 2.根据文章id查询所关联的所有标签
    @Select("SELECT * FROM tag WHERE name IN(SELECT tag_name FROM article_tag WHERE article_id=#{articleId})")
    @Results({
            @Result(column = "name", property = "name", id = true),
            @Result(column = "name", property = "articleCount", javaType = Integer.class,
                    one = @One(select = "com.hryen.blog.mapper.ArticleMapper.getArticleTotalRecordByTagName", fetchType = FetchType.LAZY))
    })
    List<Tag> getTagsByArticleId(String articleId);

    // 3.向tag表添加一个tag 如果已存在 则更新name
    @Insert("INSERT INTO tag(name) VALUES (#{tagName}) ON DUPLICATE KEY UPDATE name=#{tagName}")
    void insertArticleBindTag(@Param("tagName") String tagName);

}
