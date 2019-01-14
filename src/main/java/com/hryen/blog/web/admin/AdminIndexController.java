package com.hryen.blog.web.admin;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public class AdminIndexController extends AdminBaseController{

    @GetMapping("/index")
    public String getAdminIndex(HttpServletRequest request, Model model) {
        Object username = request.getSession().getAttribute("user");
        model.addAttribute("username", username);
        return "admin/index";
    }

}
