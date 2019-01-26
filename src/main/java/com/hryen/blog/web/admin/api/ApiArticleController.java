package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Article;
import com.hryen.blog.service.ApiArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
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
    public Map updateArticleSettingsByArticleId(@RequestBody Map data) {
        Map<String, Object> resultMap = new LinkedHashMap<>();
        try {
            apiArticleService.updateArticleSettingsByArticleId(data);
            resultMap.put("result", true);
            resultMap.put("message", "Success");
        } catch (DuplicateKeyException e) {
            resultMap.put("result", false);
            resultMap.put("message", "Duplicate Key");
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", false);
            resultMap.put("message", "failure");
        } finally {
            return resultMap;
        }
    }

    // 6.按文章id将文章移到回收站或永久删除
    @PostMapping("/deleteArticleById")
    public Map deleteArticleByArticleId(@RequestBody Map data) {
        // 获取文章id
        String articleId = (String) data.get("articleId");

        // realDelete获取是否真的删除 false将文章移到回收站 true将彻底删除
        boolean realDelete = (boolean) data.get("realDelete");

        Map<String, Object> resultMap = new LinkedHashMap<>();
        try {
            // 执行删除
            apiArticleService.deleteArticleByArticleId(articleId, realDelete);
            resultMap.put("result", true);
            resultMap.put("message", "Success");
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", false);
            resultMap.put("message", "failure");
        } finally {
            return resultMap;
        }
    }

    // 7.按文章id将文章从已删除修改为已隐藏
    @PostMapping("/restoreArticleById")
    public Map restoreArticleById(@RequestBody Map data) {

        // 获取文章id
        String articleId = (String) data.get("articleId");

        Map<String, Object> resultMap = new LinkedHashMap<>();
        try {
            // 执行恢复
            apiArticleService.restoreArticleById(articleId);
            resultMap.put("result", true);
            resultMap.put("message", "Success");
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", false);
            resultMap.put("message", "failure");
        } finally {
            return resultMap;
        }
    }

}
