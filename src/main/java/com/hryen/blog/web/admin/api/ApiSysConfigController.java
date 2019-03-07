package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Result;
import com.hryen.blog.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/api/sysconfig")
public class ApiSysConfigController {

    @Autowired
    private CommonService commonService;

    @PostMapping("/update")
    public Result updateSysConfig(@RequestBody Map data) {
        try {
            String blogTitle = (String) data.get("blogTitle");
            String blogDescription = (String) data.get("blogDescription");
            String blogOwner = (String) data.get("blogOwner");
            Integer indexPageSize = (Integer) data.get("indexPageSize");

            commonService.updateBlogTitle(blogTitle);
            commonService.updateBlogDescription(blogDescription);
            commonService.updateBlogOwner(blogOwner);
            commonService.updateIndexPageSize(indexPageSize);

            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    @GetMapping("/get")
    public Map getSysConfig() {
        Map map = new HashMap();
        map.put("blogTitle", commonService.getBlogTitle());
        map.put("blogDescription", commonService.getBlogDescription());
        map.put("blogOwner", commonService.getBlogOwner());
        map.put("indexPageSize", commonService.getIndexPageSize());
        return map;
    }

}
