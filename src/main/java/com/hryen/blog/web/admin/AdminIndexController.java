package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminIndexController {

    @GetMapping("/index")
    public String getAdminIndex(HttpServletRequest request, Model model) {
        Object username = request.getSession().getAttribute("user");
        model.addAttribute("username", username);
        return "admin/index";
    }

    @GetMapping("")
    public String redirect() {
        return "redirect:/admin/index";
    }

}
