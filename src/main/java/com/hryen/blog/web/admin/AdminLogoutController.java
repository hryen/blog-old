package com.hryen.blog.web.admin;

import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

public class AdminLogoutController extends AdminBaseController{

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        if(null != request.getSession().getAttribute("user")) {
            request.getSession().removeAttribute("user");
        }
        return "redirect:/admin/login";
    }

}
