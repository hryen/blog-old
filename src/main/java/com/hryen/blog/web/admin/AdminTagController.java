package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminTagController {

    @GetMapping("/tags")
    public String getAdminTags() {
        return "admin/tags";
    }

}
