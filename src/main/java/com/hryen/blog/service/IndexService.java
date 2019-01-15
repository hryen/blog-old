package com.hryen.blog.service;

import org.springframework.stereotype.Service;

@Service
public class IndexService {
//
//    @Autowired
//    private ArticleMapper articleMapper;
//
//    @Autowired
//    private RedisTemplate redisTemplate = new RedisTemplate();
//
//    public List<Article> getIndexWithPage(int page, int startIndex) {
//
//        // 创建文章集合
//        List<Article> articleList = new ArrayList<>();
//
//        // 如果是第一页 查询置顶文章
//        if(1 == page) {
//            List<Article> stickyArticleList = articleMapper.getStickyArticles();
//            articleList.addAll(stickyArticleList);
//        }
//
//        // 查询最新文章 带分页
//        List<Article> newestArticleList = articleMapper.getNewestArticlesWithPage(startIndex, this.getIndexPageSize());
//        articleList.addAll(newestArticleList);
//
//        // 更新文章的标题
//        ArticleUtils.updateTitle(articleList, 30);
//
//        return articleList;
//    }
//
//    public Pagination getPagination(int page) {
//        Integer articleTotalRecord = articleMapper.getArticleTotalRecord();
//        return new Pagination(page, this.getIndexPageSize(), articleTotalRecord);
//    }
//
//    public String getBlogTitle() {
//        return (String) redisTemplate.opsForValue().get("blog_option_blog_title");
//    }
//
//    public String getBlogDescription() {
//        return (String) redisTemplate.opsForValue().get("blog_option_blog_description");
//    }
//
//    private Integer getIndexPageSize() {
//        return (Integer) redisTemplate.opsForValue().get("blog_option_index_page_size");
//    }

}
