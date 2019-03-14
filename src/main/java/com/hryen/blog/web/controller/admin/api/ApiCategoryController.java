package com.hryen.blog.web.controller.admin.api;

import com.hryen.blog.model.Category;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/api/category")
public class ApiCategoryController {

    @Autowired
    private ApiCategoryService apiCategoryService;

    // 1.获取所有分类
    @GetMapping("/listAllCategory")
    public List<Category> listAllCategory() {
        return apiCategoryService.listAllCategory();
    }

    // 2.save
    @PostMapping("/save")
    public Result save(@RequestBody Category category) {
        try {
            apiCategoryService.save(category);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 2.update
    @PostMapping("/update")
    public Result update(@RequestBody Category category) {
        try {
            apiCategoryService.update(category);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 2.delete
    @PostMapping("/delete")
    public Result delete(@RequestBody Category category) {
        try {
            apiCategoryService.delete(category);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();

            String msg = "Failed";
            if ("Cannot delete default category".equals(e.getMessage())) msg = "Cannot delete default category";

            return new Result(false, msg);
        }
    }

}
