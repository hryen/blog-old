package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Tag;
import com.hryen.blog.service.ApiTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/admin/api/tag")
public class ApiTagController {

    @Autowired
    private ApiTagService apiTagService;

    // 1.获取所有标签
    @GetMapping("/listAllTag")
    public List<Tag> listAllTag() {
        return apiTagService.listAllTag();
    }

}
