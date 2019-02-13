package com.hryen.blog.web.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminSettingsController {

    @GetMapping("/settings")
    public String getAdminSettings(Model model) {
        return "admin/settings";
    }
}
