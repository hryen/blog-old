package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.mapper.TagMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.model.Tag;
import com.hryen.blog.util.Snowflake;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ApiArticleService {

    private Logger logger = LoggerFactory.getLogger(ApiArticleService.class);

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private Snowflake snowflake;

    @Autowired
    private ApiCacheService apiCacheService;

    // 1.获取所有文章的总数 不包含回收站里的
    public Integer getAllArticleTotalRecord() {
        return articleMapper.getAllArticleTotalRecord();
    }

    // 2.获取所有文章 不包含回收站里的 带分页 按日期排序
    public List<Article> listArticleWithPage(Integer pageSize, Integer currentPage) {
        Pagination pagination = new Pagination(currentPage, pageSize, this.getAllArticleTotalRecord());
        return articleMapper.listArticleWithPage(pagination.getStartIndex(), pageSize);
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
        updateArticleSettingsAndContent(data, false);
        // clean index cache
        apiCacheService.cleanIndexArticleListCache();

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
        apiCacheService.cleanArticleCache(id);

        // clean index cache
        apiCacheService.cleanIndexArticleListCache();
    }

    // 7.按文章id将文章从已删除修改为已隐藏
    @Transactional
    public void restoreArticleById(String articleId) {
        articleMapper.updateArticleStatusByArticleId(articleId, 1);
        apiCacheService.cleanArticleCache(articleId);

        // clean index cache
        apiCacheService.cleanIndexArticleListCache();

        logger.info("Restore article: " + articleId);
    }

    // 8.新建文章
    @Transactional
    public void newArticle(Article article) {
        // set id
        article.setId(String.valueOf(snowflake.nextId()));

        // set publish date
        article.setPublishDate(new Date());

        // set last modified date
        article.setLastModifiedDate(new Date());

        // insert
        articleMapper.save(article);

        // 向数据库插入文章与标签的关系
        List<Tag> tagList = article.getTagList();
        for (Tag tag : tagList) {
            articleMapper.insertArticleBindTag(article.getId(), tag.getName());
        }

        // clean index cache
        apiCacheService.cleanIndexArticleListCache();
    }

    // 9.根据文章id更新文章 包含内容
    @Transactional
    public void updateArticleByArticleId(Map data) {
        updateArticleSettingsAndContent(data, true);
        // clean index cache
        apiCacheService.cleanIndexArticleListCache();
    }

    // 根据文章id获取文章
    public Article getArticleByArticleId(String articleId) {
        return articleMapper.getArticleByArticlePermalinkOrId(articleId);
    }

    // 更新文章设置或内容
    private void updateArticleSettingsAndContent(Map data, boolean updateContent) {
        // 类型转换
        String id = (String) data.get("id");
        String title = (String) data.get("title");
        String permalink = (String) data.get("permalink");
        Integer status = Integer.valueOf(String.valueOf(data.get("status")));
        LinkedHashMap<String, String> categoryMap = (LinkedHashMap) data.get("category");
        String categoryId = categoryMap.get("id");
        boolean commentStatus = (boolean) data.get("commentStatus");
        ArrayList<String> tagNameList = (ArrayList) data.get("tagNameList");

        // 如果内容需要更新
        if (updateContent) {
            // 获取内容部分
            String markdownContent = (String) data.get("markdownContent");
            String htmlContent = (String) data.get("htmlContent");
            String summary = (String) data.get("summary");

            //执行更新
            articleMapper.updateArticleSettingsAndContentByArticleId(id,
                    title,
                    permalink,
                    categoryId,
                    commentStatus,
                    new Date(),
                    status,
                    markdownContent,
                    htmlContent,
                    summary);
        } else {
            // 更新设置
            articleMapper.updateArticleSettingsByArticleId(id,
                    title,
                    permalink,
                    categoryId,
                    commentStatus,
                    new Date(),
                    status);
        }

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
        apiCacheService.cleanArticleCache(id);
    }

}
