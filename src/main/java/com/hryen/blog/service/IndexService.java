package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class IndexService {

    @Autowired
    private CommonService commonService;

    @Autowired
    private ArticleMapper articleMapper;

    @Cacheable(value = "blog_index", key = "'articleList'")
    public List<Article> getIndexWithPage(Integer pageNumber, Integer startIndex) {

        // 创建文章集合
        List<Article> articleList = new ArrayList<>();

        // 如果是第一页 查询置顶文章
        if (1 == pageNumber) {
            Article stickyArticle = articleMapper.getStickyArticle();
            if (null != stickyArticle) { articleList.add(stickyArticle); }
        }

        // 查询最新文章 带分页
        List<Article> newestArticleList = articleMapper.getNewestArticlesWithPage(startIndex, commonService.getIndexPageSize());
        articleList.addAll(newestArticleList);

//        // 更新文章的标题
//        ArticleUtils.updateTitle(articleList, 30);

        return articleList;
    }

    // 获取分页
    public Pagination getPagination(Integer pageNumber) {
        Integer articleTotalRecord = articleMapper.getArticleTotalRecord();
        Integer indexPageSize = commonService.getIndexPageSize();
        return new Pagination(pageNumber, indexPageSize, articleTotalRecord);
    }

}
