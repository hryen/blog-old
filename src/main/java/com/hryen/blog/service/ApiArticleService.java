package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.mapper.TagMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.model.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
public class ApiArticleService {

    private Logger logger = LoggerFactory.getLogger(ApiArticleService.class);

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    // 1.获取所有文章的总数 不包含回收站里的
    public Integer getAllArticleTotalRecord() {
        return articleMapper.getAllArticleTotalRecord();
    }

    // 2.获取所有文章 不包含回收站里的 带分页 按日期排序
    public List<Article> getAllArticleWithPage(Integer pageSize, Integer currentPage) {
        Pagination pagination = new Pagination(currentPage, pageSize, this.getAllArticleTotalRecord());
        return articleMapper.getAllArticleWithPage(pagination.getStartIndex(), pageSize);
    }

    // 3.获取回收站里的文章的总数
    public Integer getTrashArticleTotalRecord() {
        return articleMapper.getTrashArticleTotalRecord();
    }

    // 4.获取回收站里的所有文章 带分页 按日期排序
    public List<Article> getTrashArticleWithPage(Integer pageSize, Integer currentPage) {
        Pagination pagination = new Pagination(currentPage, pageSize, this.getAllArticleTotalRecord());
        return articleMapper.getTrashArticleWithPage(pagination.getStartIndex(), pageSize);
    }

    // 5.根据文章id更新文章设置
    @Transactional
    public void updateArticleSettingsByArticleId(Map data) {
        // 类型转换
        String id = (String) data.get("id");
        String title = (String) data.get("title");
        String permalink = (String) data.get("permalink");
        Integer status = Integer.valueOf(String.valueOf(data.get("status")));
        String categoryName = (String) data.get("categoryName");
        boolean commentStatus = (boolean) data.get("commentStatus");
        ArrayList<String> tagNameList = (ArrayList) data.get("tagNameList");

        // 更新设置
        articleMapper.updateArticleSettingsByArticleId(id,
                title,
                permalink,
                categoryName,
                commentStatus,
                new Date(),
                status);

        // 更新标签关联 先删除已存在关联 再重新关联
        // 如果是新标签 要先创建
        articleMapper.cleanArticleBindTags(id);

        for (String tagName : tagNameList) {
            // 将标签转成全小写
            tagName = tagName.toLowerCase();
            // 尝试添加标签
            tagMapper.insertArticleBindTag(tagName);
            // 将文章和标签关联
            articleMapper.insertArticleBindTag(id, tagName);
        }

        //删除redis
        cleanRedisArticleByArticleId(id);
        cleanRedisArticleByArticlePermalink(permalink);

        logger.info("Update article settings: " + id);

    }

    // 6.根据文章id删除文章 realDelete为true代表删除 为false代表标记为删除
    @Transactional
    public void deleteArticleByArticleId(String id, boolean realDelete) {
        if (realDelete) {
            // 根据文章id清除文章与标签的关联
            articleMapper.cleanArticleBindTags(id);
            articleMapper.deleteArticleByArticleId(id);
            logger.info("Delete article: " + id);
        } else {
            articleMapper.updateArticleStatusByArticleId(id, 3); // status:3代表已删除
            logger.info("Hidden article: " + id);
        }

        //删除redis
        cleanRedisArticleByArticleId(id);


    }

    // 7.按文章id将文章从已删除修改为已隐藏
    @Transactional
    public void restoreArticleById(String articleId) {
        articleMapper.updateArticleStatusByArticleId(articleId, 1);
        cleanRedisArticleByArticleId(articleId);

        logger.info("Restore article: " + articleId);
    }

    // 8.新建文章
    @Transactional
    public void newArticle(Article article) {
        // TODO article.id 换成twitter雪花算法
        article.setId( new SimpleDateFormat("yyMMddHHmm").format(new Date()));
        article.setPublishDate(new Date());
        article.setLastModifiedDate(new Date());

        // 向数据库插入文章
        articleMapper.newArticle(article);

        // 向数据库插入文章与标签的关系
        List<Tag> tagList = article.getTagList();
        for (Tag tag : tagList) {
            articleMapper.insertArticleBindTag(article.getId(), tag.getName());
        }

    }

    // 按文章id删除redis
    private void cleanRedisArticleByArticleId(String id) {
        if (null != id) {
            stringRedisTemplate.boundValueOps("blog_article::" + id).expire(0, TimeUnit.SECONDS);
        }
    }

    // 按文章固定链接删除redis
    private void cleanRedisArticleByArticlePermalink(String permalink) {
        if (null != permalink) {
            stringRedisTemplate.boundValueOps("blog_article::" + permalink).expire(0, TimeUnit.SECONDS);
        }
    }

}
