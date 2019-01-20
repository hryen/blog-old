package com.hryen.blog.util;

import com.hryen.blog.model.Tag;

import java.util.Iterator;
import java.util.List;

public class TagUtils {

    // 更新标签list中所有标签的级别
    public static List<Tag> updateTagsLevel(List<Tag> tagList) {
        Iterator<Tag> iterator = tagList.iterator();
        while (iterator.hasNext()) {
            Tag tag = iterator.next();
            // 如果标签下文章数为0 将此标签从list中移除
            if (tag.getArticleCount() == 0) {
                iterator.remove();
            } else {
                tag.setLevel(getTagLevel(tag));
            }
        }
        return tagList;
    }

    /**
     * 根据标签下的文章数为标签划分级别
     * 级别 文章数
     * l6   0-2
     * l5   3-5
     * l4   6-8
     * l3   9-11
     * l2   12-14
     * l1   15+
     */
    public static Integer getTagLevel(Tag tag) {

        if (null == tag || null == tag.getArticleCount()) {
            return null;
        }

        Integer articleCount = tag.getArticleCount();
        if (articleCount >= 0 && articleCount <= 2) {
            return 6;
        } else if (articleCount >= 3 && articleCount <= 5) {
            return 5;
        } else if (articleCount >= 6 && articleCount <= 8) {
            return 4;
        } else if (articleCount >= 9 && articleCount <= 11) {
            return 3;
        } else if (articleCount >= 12 && articleCount <= 14) {
            return 2;
        } else {
            return 1;
        }
    }

}
