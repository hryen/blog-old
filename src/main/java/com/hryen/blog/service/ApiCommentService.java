package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.mapper.CommentMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Comment;
import com.hryen.blog.util.MD5Utils;
import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Date;

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
        if ("".equals(url.trim())) {
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
            apiCacheService.cleanArticleCache(article.getPermalink());
        } else {
            throw new Exception("This article does not allow comments");
        }
    }

    // 2.delete
    @Transactional
    public void delete(Comment comment) {
        String commentId = comment.getId();
        commentMapper.delete(commentId);
    }

}
