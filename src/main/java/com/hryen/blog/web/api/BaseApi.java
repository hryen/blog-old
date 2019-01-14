package com.hryen.blog.web.api;

import com.hryen.blog.model.Navigation;
import com.hryen.blog.service.CommonService;
import com.hryen.blog.service.SysConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class BaseApi {

    @Autowired
    private SysConfigService sysConfigService;

    @Autowired
    private CommonService commonService;

    @GetMapping("/getBlogTitle")
    public String getBlogTitle() {
        return sysConfigService.getBlogTitle();
    }

    @GetMapping("/getNavigation")
    public List<Navigation> getNavigation() {
        return commonService.getNavigation();
    }

    @GetMapping("/getBlogOwner")
    public String getBlogOwner() {
        return sysConfigService.getBlogOwner();
    }
}
