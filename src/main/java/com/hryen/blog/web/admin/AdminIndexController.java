package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminIndexController {

    // 1.后台首页
    @GetMapping("/index")
    public String getAdminIndex(HttpServletRequest request, Model model) {
        Object user = request.getSession().getAttribute("user");
        model.addAttribute("user", user);
        return "admin/index";
    }

    // 跳转到admin首页
    @GetMapping("")
    public String redirect() {
        return "redirect:/admin/index";
    }

}
