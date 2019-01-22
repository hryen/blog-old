package com.hryen.blog.util;

import com.hryen.blog.model.Article;
import java.util.List;

public class ArticleUtils {

    // 更新一个文章list里所有文章的标题
    public static List<Article> substringTitle(List<Article> articleList, int index) {
        for (Article article : articleList) {
            article.setTitle(substringTitle(article.getTitle(), index));
        }
        return articleList;
    }

    // 更新标题
    public static String substringTitle(String title, int index) {
        // 如果标题太长 将后面的替换成省略号
        if(title.length() > index) {
            return title.substring(0, index) + "...";
        }
        return title;
    }

}
