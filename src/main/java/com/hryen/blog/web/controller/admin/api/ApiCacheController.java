package com.hryen.blog.web.controller.admin.api;

import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiCacheService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/api/cache")
public class ApiCacheController {

    @Autowired
    private ApiCacheService apiCacheService;

    // 1.清除首页文章缓存
    @GetMapping("/cleanIndexArticleListCache")
    public Result cleanIndexArticleListCache() {
        try {
            apiCacheService.cleanIndexArticleListCache();
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 2.清除所有文章缓存
    @GetMapping("/cleanArticleCache")
    public Result cleanArticleCache() {
        try {
            apiCacheService.cleanArticleCache();
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 3.清除所有博客设置缓存
    @GetMapping("/cleanBlogSysConfigCache")
    public Result cleanBlogSysConfigCache() {
        try {
            apiCacheService.cleanBlogSysConfigCache();
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

}
