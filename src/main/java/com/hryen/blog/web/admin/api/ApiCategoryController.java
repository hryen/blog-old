package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Category;
import com.hryen.blog.service.ApiCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin
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

}
