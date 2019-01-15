package com.hryen.blog.mapper;

import org.apache.ibatis.annotations.*;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Category;
import java.util.List;

@Mapper
public interface ArticleMapper {

    // 查询文章总数 不计算隐藏文章
    @Select("SELECT COUNT(0) FROM article WHERE status=0")
    Integer getArticleTotalRecord();

    // 根据分类name查询文章数 不计算隐藏文章
    @Select("SELECT COUNT(0) FROM article WHERE category_name=#{categoryName} AND status=0")
    Integer getArticleTotalRecordByCategoryName(String categoryName);

    // 根据标签name查询文章数 不计算隐藏文章
    @Select("SELECT COUNT(0) FROM article WHERE id IN(SELECT article_id FROM article_tag WHERE tag_name=#{tagName}) AND status=0")
    Integer getArticleTotalRecordByTagName(String tagName);



    // 根据文章id查询文章
    @Select("SELECT * FROM article WHERE id=#{articleId}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "category", javaType = Category.class,
                    one = @One(select = "com.hryen.blog.mapper.CategoryMapper.getCategoryByCategoryName")),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
    })
    Article getArticleByArticleId(String articleId);






//    // 查询非隐藏非置顶文章 按日期排序 带分页
//    @Select("SELECT * FROM article WHERE status=0 ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
//    @Results({
//            @Result(column = "id", property = "id", id = true),
//            @Result(column = "publish_date", property = "publishDate"),
//            @Result(column = "last_modified_date", property = "lastModifiedDate"),
//            @Result(column = "markdown_content", property = "markdownContent"),
//            @Result(column = "html_content", property = "htmlContent"),
//            @Result(column = "category_id", property = "category", javaType = Category.class,
//                    one = @One(select = "com.hryen.blog.mapper.CategoryMapper.getCategoryByCategoryId")),
//            @Result(column = "id", property = "tagList", javaType = List.class,
//                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
//    })
//    List<Article> getNewestArticlesWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);



//
//    // 根据分类id查询文章 按日期排序 带分页
//    @Select("SELECT * FROM article WHERE status=0 AND category_id=#{categoryId} ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
//    @Results({
//            @Result(column = "id", property = "id", id = true),
//            @Result(column = "publish_date", property = "publishDate"),
//            @Result(column = "last_modified_date", property = "lastModifiedDate"),
//            @Result(column = "markdown_content", property = "markdownContent"),
//            @Result(column = "html_content", property = "htmlContent"),
//            @Result(column = "category_id", property = "category", javaType = Category.class,
//                    one = @One(select = "com.hryen.blog.mapper.CategoryMapper.getCategoryByCategoryId")),
//            @Result(column = "id", property = "tagList", javaType = List.class,
//                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
//    })
//    List<Article> getArticlesByCategoryIdWithPage(@Param("categoryId") String categoryId, @Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);
}
