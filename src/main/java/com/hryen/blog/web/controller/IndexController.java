package com.hryen.blog.web.controller;

import com.hryen.blog.model.Navigation;
import com.hryen.blog.service.CommonService;
import com.hryen.blog.service.SysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private SysConfigService sysConfigService;

    @Autowired
    private CommonService commonService;

    @GetMapping("/")
    public String getIndex(Model model) {

        List<Navigation> navigationList = commonService.getNavigations();
        model.addAttribute("navigationList", navigationList);

        String blogTitle = sysConfigService.getBlogTitle();
        model.addAttribute("blogTitle", blogTitle);

        String blogDescription = sysConfigService.getBlogDescription();
        model.addAttribute("blogDescription", blogDescription);

        return "index";
    }
}
