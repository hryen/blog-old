package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminLogoutController {

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        if(null != request.getSession().getAttribute("user")) {
            request.getSession().removeAttribute("user");
        }
        return "redirect:/admin/login";
    }

}
