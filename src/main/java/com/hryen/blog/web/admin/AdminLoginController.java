package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {

    @GetMapping("/login")
    public String getAdminLogin(HttpServletRequest request, Model model) {
        // 如果已登录 跳转到admin首页
        if (null != request.getSession().getAttribute("user")) {
            return "redirect:/admin";
        }
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(String username, String password, HttpServletRequest request) {
        if (username.equals("henry") && password.equals("123.com")) {
            request.getSession().setAttribute("user", "henry");
        } else {
            return "redirect:/admin/login";
        }
        return "redirect:/admin";
    }

}
