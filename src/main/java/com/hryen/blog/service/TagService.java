package com.hryen.blog.service;

import com.hryen.blog.mapper.ArticleMapper;
import com.hryen.blog.mapper.TagMapper;
import com.hryen.blog.model.Article;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.model.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CommonService commonService;

    // 获取所有标签
    public List<Tag> getAllTags() {
        return tagMapper.getAllTags();
    }

    // 根据标签name查询非隐藏文章 按日期排序 带分页
    public List<Article> getArticlesByTagNameWithPage(String tagName, Integer startIndex) {
        List<Article> articleList = articleMapper.getArticlesByTagNameWithPage(tagName, startIndex, commonService.getIndexPageSize());
        return articleList;
    }

    // 获取分页
    public Pagination getPagination(String tagName, Integer pageNumber) {
        Integer articleTotalRecord = articleMapper.getArticleTotalRecordByTagName(tagName);
        Integer indexPageSize = commonService.getIndexPageSize();
        return new Pagination(pageNumber, indexPageSize, articleTotalRecord);
    }

}
