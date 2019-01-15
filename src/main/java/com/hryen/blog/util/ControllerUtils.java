package com.hryen.blog.util;

import com.hryen.blog.model.Navigation;
import com.hryen.blog.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ControllerUtils {

    @Autowired
    private CommonService commonService;

    public int checkPage(String page) {

        // 如果没有页码 返回第一页
        if (null == page) {
            return 1;
        }

        try {
            int newPage;
            newPage = Integer.valueOf(page);
            // 如果页码<=0 返回-1
            if (newPage <= 0) {
                return -1;
            }
            return newPage;
        } catch (Exception e) {
            // 如果参数非法 返回-1
            return -1;
        }
    }



    // 获取博客的 标题，描述，导航，所属者 返回map
    public Map<String, Object> getCommonAttributes() {

        String blogTitle = commonService.getBlogTitle();
        String blogDescription = commonService.getBlogDescription();
        List<Navigation> navigationList = commonService.getNavigation();
        String blogOwner = commonService.getBlogOwner();

        Map<String, Object> map = new HashMap<>();
        map.put("blogTitle", blogTitle);
        map.put("blogDescription", blogDescription);
        map.put("navigationList", navigationList);
        map.put("blogOwner", blogOwner);

        return map;
    }

}
