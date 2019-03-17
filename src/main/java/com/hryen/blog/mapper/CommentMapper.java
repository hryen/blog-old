package com.hryen.blog.mapper;

import com.hryen.blog.model.Comment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CommentMapper {

    // 1.save
    @Insert("INSERT INTO `comment`" +
            "(`id`, `article_id`, `content`, `publish_date`, `parent_id`, `author`, `email`, `email_md5`, `url`)" +
            "VALUES" +
            "(#{comment.id}, #{comment.articleId}, #{comment.content}, #{comment.publishDate}," +
            "#{comment.parentId}, #{comment.author}, #{comment.email}, #{comment.emailMD5}, #{comment.url})")
    void save(@Param("comment") Comment comment);

    // 2.delete
    @Delete("DELETE FROM `comment` WHERE `id`=#{id}")
    void delete(String id);

    // 3.根据文章id查询所有的评论 根节点
    @Select("SELECT * FROM `comment` WHERE `article_id`=#{id} AND `parent_id` IS NULL ORDER BY `publish_date` DESC")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "email_md5", property = "emailMD5"),
            @Result(column = "article_id", property = "articleId"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "parent_id", property = "parentComment", javaType = Comment.class,
                    one = @One(select = "com.hryen.blog.mapper.CommentMapper.getCommentByCommentId")),
            @Result(column = "id", property = "childCommentList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.CommentMapper.listChildComments"))
    })
    List<Comment> listCommentsByArticleId(String id);

    // 4.根据parentId查询该评论下的子评论
    @Select("SELECT * FROM `comment` WHERE `parent_id`=#{id} ORDER BY `publish_date` ASC")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "email_md5", property = "emailMD5"),
            @Result(column = "article_id", property = "articleId"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "parent_id", property = "parentComment", javaType = Comment.class,
                    one = @One(select = "com.hryen.blog.mapper.CommentMapper.getCommentByCommentId")),
            @Result(column = "id", property = "childCommentList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.CommentMapper.listChildComments"))
    })
    List<Comment> listChildComments(String id);

    // 5.根据文章id获取评论数
    @Select("SELECT COUNT(0) FROM `comment` WHERE `article_id`=#{id}")
    Integer countCommentTotalRecordByArticleId(String id);

    // 6.根据id获取评论
    @Select("SELECT * FROM `comment` WHERE `id`=#{id}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "email_md5", property = "emailMD5"),
            @Result(column = "article_id", property = "articleId"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "parent_id", property = "parentComment", javaType = Comment.class,
                    one = @One(select = "com.hryen.blog.mapper.CommentMapper.getCommentByCommentId")),
            @Result(column = "id", property = "childCommentList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.CommentMapper.listChildComments"))
    })
    Comment getCommentByCommentId(String id);

    // 7.获取所有评论 带分页 按日期排序
    @Select("SELECT * FROM `comment` ORDER BY `publish_date` DESC LIMIT #{startIndex},#{pageSize}")
    @Results({
            @Result(column = "id", property = "id", id = true),
            @Result(column = "publish_date", property = "publishDate"),
            @Result(column = "email_md5", property = "emailMD5"),
            @Result(column = "article_id", property = "articleId"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "parent_id", property = "parentComment", javaType = Comment.class,
                    one = @One(select = "com.hryen.blog.mapper.CommentMapper.getCommentByCommentId")),
            @Result(column = "id", property = "childCommentList", javaType = List.class,
                    many = @Many(select = "com.hryen.blog.mapper.CommentMapper.listChildComments"))
    })
    List<Comment> listCommentsWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 8.get all comment total record
    @Select("SELECT COUNT(0) FROM `comment`")
    Integer getAllCommentTotalRecord();

}
