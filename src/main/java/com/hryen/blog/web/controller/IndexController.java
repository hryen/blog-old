package com.hryen.blog.web.controller;

import com.hryen.blog.service.SysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @Autowired
    private SysConfigService sysConfigService;

    @GetMapping("/")
    public String getIndex() {
        System.out.println(sysConfigService.getBlogTitle());
        return "index";
    }
}
