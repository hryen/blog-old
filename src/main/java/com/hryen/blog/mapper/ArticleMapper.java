package com.hryen.blog.mapper;

import org.apache.ibatis.annotations.*;
import com.hryen.blog.model.Article;
import org.apache.ibatis.mapping.FetchType;

import java.util.Date;
import java.util.List;

@Mapper
public interface ArticleMapper {

    // 获取文章总数 包含[已发布,已隐藏,已置顶]
    @Select("SELECT COUNT(0) FROM article WHERE status IN(0, 1, 2)")
    Integer getAllArticleTotalRecord();

    // 获取文章总数 包含[已发布,已置顶]
    @Select("SELECT COUNT(0) FROM article WHERE status IN(0, 2)")
    Integer getArticleTotalRecord();

    // 根据分类name查询文章数 不计算隐藏文章
    @Select("SELECT COUNT(0) FROM article WHERE category_name=#{categoryName} AND status IN(0,2)")
    Integer getArticleTotalRecordByCategoryName(String categoryName);

    // 根据分类name查询文章数
    @Select("SELECT COUNT(0) FROM article WHERE category_name=#{categoryName}")
    Integer countArticleTotalRecordByCategoryName(String categoryName);

    // 根据标签name查询文章数 不计算隐藏文章
    @Select("SELECT COUNT(0) FROM article WHERE id IN(SELECT article_id FROM article_tag WHERE tag_name=#{tagName}) AND status IN(0,2)")
    Integer getArticleTotalRecordByTagName(String tagName);

    // 根据标签name查询文章数
    @Select("SELECT COUNT(0) FROM article WHERE id IN(SELECT article_id FROM article_tag WHERE tag_name=#{tagName})")
    Integer countArticleTotalRecordByTagName(String tagName);

    // 根据文章id或固定链接查询文章
    @Select("SELECT * FROM article WHERE id=#{str} OR permalink=#{str}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
    })
    Article getArticleByArticlePermalinkOrId(String str);

    // 查询置顶文章
    @Select("SELECT * FROM article WHERE status=2")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
    })
    Article getStickyArticle();

    // 查询所有非隐藏非置顶文章 按日期排序 带分页
    @Select("SELECT * FROM article WHERE status=0 ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId", fetchType = FetchType.LAZY))
    })
    List<Article> getNewestArticlesWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 根据分类name查询非隐藏文章 按日期排序 带分页
    @Select("SELECT * FROM article WHERE status IN(0,2) AND category_name=#{categoryName} ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId", fetchType = FetchType.LAZY))
    })
    List<Article> getArticlesByCategoryNameWithPage(@Param("categoryName") String categoryName, @Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 根据标签name查询非隐藏文章 按日期排序 带分页
    @Select("SELECT * FROM article WHERE id IN(SELECT article_id FROM article_tag WHERE tag_name=#{tagName}) AND status IN(0,2) ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId", fetchType = FetchType.LAZY))
    })
    List<Article> getArticlesByTagNameWithPage(@Param("tagName") String tagName, @Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 获取所有文章 不包含已标记为删除的 带分页 按日期排序
    @Select("SELECT * FROM article WHERE status != 3 ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
    })
    List<Article> listArticleWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 根据文章id更新文章状态
    @Update("UPDATE article SET status=#{status} WHERE id=#{id}")
    void updateArticleStatusByArticleId (String id, Integer status);

    // 根据文章id删除文章
    @Delete("DELETE FROM article WHERE id=#{id}")
    void deleteArticleByArticleId(String id);

    // 根据文章id 清理article_tag表
    @Delete("DELETE FROM article_tag WHERE article_id=#{id}")
    void cleanArticleBindTags(String id);

    // 3.获取回收站里的文章的总数
    @Select("SELECT COUNT(0) FROM article WHERE status=3")
    Integer getTrashArticleTotalRecord();

    // 4.获取回收站里的所有文章 带分页 按日期排序
    @Select("SELECT * FROM article WHERE status=3 ORDER BY publish_date DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "last_modified_date", property = "lastModifiedDate"),
            @Result(column = "markdown_content", property = "markdownContent"),
            @Result(column = "html_content", property = "htmlContent"),
            @Result(column = "category_name", property = "categoryName"),
            @Result(column = "comment_status", property = "commentStatus"),
            @Result(column = "id", property = "tagList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.TagMapper.getTagsByArticleId"))
    })
    List<Article> getTrashArticleWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 5.按文章id更新文章设置
    @Update("UPDATE article SET title=#{title}," +
            "permalink=#{permalink}," +
            "category_name=#{categoryName}," +
            "comment_status=#{commentStatus}," +
            "last_modified_date=#{lastModifiedDate}," +
            "status=#{status} WHERE id=#{id}")
    void updateArticleSettingsByArticleId(@Param("id") String id,
                                          @Param("title") String title,
                                          @Param("permalink") String permalink,
                                          @Param("categoryName") String categoryName,
                                          @Param("commentStatus") boolean commentStatus,
                                          @Param("lastModifiedDate") Date lastModifiedDate,
                                          @Param("status") Integer status);


    // 6.根据文章id和tagName  向article_tag表添加记录
    @Insert("INSERT INTO article_tag(article_id, tag_name) VALUES (#{id}, #{tagName})")
    void insertArticleBindTag(@Param("id") String id, @Param("tagName") String tagName);

    // 7.新建文章
    @Insert("INSERT INTO article(id, title," +
            "permalink, publish_date, last_modified_date," +
            "category_name, summary, markdown_content," +
            "html_content, status, comment_status)" +
            "VALUES" +
            "(#{article.id}, #{article.title}, #{article.permalink}," +
            "#{article.publishDate}, #{article.lastModifiedDate}," +
            "#{article.categoryName}, #{article.summary}, #{article.markdownContent}," +
            "#{article.htmlContent}, #{article.status}, #{article.commentStatus})")
    void newArticle(@Param("article") Article article);

    // 8.按文章id更新文章内容和设置
    @Update("UPDATE article SET title=#{title}," +
            "permalink=#{permalink}," +
            "category_name=#{categoryName}," +
            "comment_status=#{commentStatus}," +
            "last_modified_date=#{lastModifiedDate}," +
            "status=#{status}," +
            "markdown_content=#{markdownContent}," +
            "html_content=#{htmlContent}," +
            "summary=#{summary} WHERE id=#{id}")
    void updateArticleSettingsAndContentByArticleId(@Param("id") String id,
                                          @Param("title") String title,
                                          @Param("permalink") String permalink,
                                          @Param("categoryName") String categoryName,
                                          @Param("commentStatus") boolean commentStatus,
                                          @Param("lastModifiedDate") Date lastModifiedDate,
                                          @Param("status") Integer status,
                                          @Param("markdownContent") String markdownContent,
                                          @Param("htmlContent") String htmlContent,
                                          @Param("summary") String summary);

}
