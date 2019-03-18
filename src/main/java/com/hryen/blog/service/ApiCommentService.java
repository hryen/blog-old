package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.mapper.CommentMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Comment;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.util.MD5Utils;
import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ApiCommentService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private Snowflake snowflake;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private ApiCacheService apiCacheService;

    // 1.save
    @Transactional
    public void save(Comment comment) throws Exception {

        String content = comment.getContent();
        if ("".equals(content.trim())) {
            throw new Exception("No content");
        }

        String author = comment.getAuthor();
        if ("".equals(author.trim())) {
            throw new Exception("No author");
        }

        String url = comment.getUrl();
        if (null == url || "".equals(url.trim())) {
            comment.setUrl(null);
        }

        // get article
        String articleId = comment.getArticleId();
        Article article = articleMapper.getArticleByArticlePermalinkOrId(articleId);

        // get article comment status
        boolean commentStatus = article.isCommentStatus();

        if(commentStatus) {
            // set id
            long id = snowflake.nextId();
            comment.setId(String.valueOf(id));

            // set publish date
            comment.setPublishDate(new Date());

            // set emailMD5
            String email = comment.getEmail();
            if (null != email) {
                String emailMD5 = MD5Utils.encode(email.toLowerCase().trim());
                comment.setEmailMD5(emailMD5);
            }

            // save
            commentMapper.save(comment);

            // clean cache
            apiCacheService.cleanArticleCache(articleId);
        } else {
            throw new Exception("This article does not allow comments");
        }
    }

    // 2.delete
    @Transactional
    public void delete(Comment comment) {
        // get child comments
        deleteChildComments(comment.getId());

        // clean cache
        apiCacheService.cleanArticleCache(comment.getArticleId());
    }

    // 3.list all
    public List<Comment> listCommentsWithPage(Integer pageSize, Integer currentPage) {
        Pagination pagination = new Pagination(currentPage, pageSize, this.getAllCommentTotalRecord());
        return commentMapper.listCommentsWithPage(pagination.getStartIndex(), pageSize);
    }

    // 4.get all comment total record
    public Integer getAllCommentTotalRecord() {
        return commentMapper.getAllCommentTotalRecord();
    }

    // 递归删除评论和子评论
    private void deleteChildComments(String id) {
        List<Comment> childComments = commentMapper.listChildComments(id);
        if (childComments.size() > 0) {
            for (Comment childComment : childComments) {
                deleteChildComments(childComment.getId());
            }
        }
        commentMapper.delete(id);
    }

    // delete comments by article id
    @Transactional
    public void deleteCommentsByArticleId(String id) {
        commentMapper.deleteCommentsByArticleId(id);
    }
}
