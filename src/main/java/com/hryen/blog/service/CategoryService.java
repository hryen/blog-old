package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CommonService commonService;

    // 根据分类name查询非隐藏文章 按日期排序 带分页
    public List<Article> getArticlesByCategoryNameWithPage(String categoryName, Integer startIndex) {
        List<Article> articleList = articleMapper.getArticlesByCategoryNameWithPage(categoryName, startIndex, commonService.getIndexPageSize());
        return articleList;
    }

    // 获取分页
    public Pagination getPagination(String categoryName, Integer pageNumber) {
        Integer articleTotalRecord = articleMapper.getArticleTotalRecordByCategoryName(categoryName);
        Integer indexPageSize = commonService.getIndexPageSize();
        return new Pagination(pageNumber, indexPageSize, articleTotalRecord);
    }

}
