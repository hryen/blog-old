package com.hryen.blog.web.controller;

import org.springframework.stereotype.Controller;


@Controller
public class IndexController {
//
//    @Autowired
//    private CommonService commonService;
//
//    @Autowired
//    private IndexService indexService;
//
//    @GetMapping("/")
//    public String getIndexWithPage(String page, Model model) {
//
//        // 检查参数
//        int PageNumber = ControllerUtils.checkPage(page);
//        // 如果参数非法 跳转到首页
//        if (-1 == PageNumber) {
//            return "redirect:/";
//        }
//
//        // 分页
//        Pagination pagination = indexService.getPagination(PageNumber);
//        model.addAttribute("pagination", pagination);
//
//        // 文章list
//        List<Article> articleList = indexService.getIndexWithPage(PageNumber, pagination.getStartIndex());
//        model.addAttribute("articleList", articleList);
//
//        List<Navigation> navigationList = commonService.getNavigation();
//        model.addAttribute("navigationList", navigationList);
//
//        String blogTitle = sysConfigService.getBlogTitle();
//        model.addAttribute("blogTitle", blogTitle);
//
//        String blogDescription = sysConfigService.getBlogDescription();
//        model.addAttribute("blogDescription", blogDescription);
//
//        return "index";
//    }
}
