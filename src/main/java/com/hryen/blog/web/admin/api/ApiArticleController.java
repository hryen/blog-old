package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Article;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/api/article")
public class ApiArticleController {

    @Autowired
    private ApiArticleService apiArticleService;

    // 1.获取所有文章的总数 不包含回收站里的
    @GetMapping("/getAllArticleTotalRecord")
    public Integer getAllArticleTotalRecord() {
        return apiArticleService.getAllArticleTotalRecord();
    }

    // 2.获取所有文章 不包含回收站里的 带分页 按日期排序
    @GetMapping("/getAllArticleWithPage")
    public List<Article> getAllArticleWithPage(Integer pageSize, Integer currentPage) {
        if (null == pageSize || null == currentPage) { return null; }
        return apiArticleService.getAllArticleWithPage(pageSize, currentPage);
    }

    // 3.获取回收站里的文章的总数
    @GetMapping("/getTrashArticleTotalRecord")
    public Integer getTrashArticleTotalRecord() {
        return apiArticleService.getTrashArticleTotalRecord();
    }

    // 4.获取回收站里的所有文章 带分页 按日期排序
    @GetMapping("/getTrashArticleWithPage")
    public List<Article> getTrashArticleWithPage(Integer pageSize, Integer currentPage) {
        if (null == pageSize || null == currentPage) { return null; }
        return apiArticleService.getTrashArticleWithPage(pageSize, currentPage);
    }

    // 5.按文章id更新文章设置
    @PostMapping("/updateArticleSettingsByArticleId")
    public Result updateArticleSettingsByArticleId(@RequestBody Map data) {
        try {
            apiArticleService.updateArticleSettingsByArticleId(data);
            return new Result(true, "Successful");
        } catch (DuplicateKeyException e) {
            return new Result(false, "Permalink already exists");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 6.按文章id将文章移到回收站或永久删除
    @PostMapping("/deleteArticleById")
    public Result deleteArticleByArticleId(@RequestBody Map data) {
        // 获取文章id
        String articleId = (String) data.get("articleId");

        // realDelete获取是否真的删除 false将文章移到回收站 true将彻底删除
        boolean realDelete = (boolean) data.get("realDelete");

        try {
            // 执行删除
            apiArticleService.deleteArticleByArticleId(articleId, realDelete);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 7.按文章id将文章从已删除修改为已隐藏
    @PostMapping("/restoreArticleById")
    public Result restoreArticleById(@RequestBody Map data) {

        // 获取文章id
        String articleId = (String) data.get("articleId");

        try {
            // 执行恢复
            apiArticleService.restoreArticleById(articleId);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 8.新建文章
    @PostMapping("/newArticle")
    public Result newArticle(@RequestBody Article article) {
        try {
            // 执行新建
            apiArticleService.newArticle(article);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

}
