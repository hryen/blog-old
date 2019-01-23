package com.hryen.blog.web.admin;

import eu.bitwalker.useragentutils.UserAgent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/admin")
public class AdminLogoutController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        if(null != request.getSession().getAttribute("user")) {

            // 获取userAgent
            UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));

            // 删除session
            request.getSession().removeAttribute("user");

            // 删除cookie
            Cookie cookie = new Cookie("UID", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);

            // 删除redis
            stringRedisTemplate.boundValueOps("blog_user_agent_id_" + userAgent.getId()).expire(0L, TimeUnit.SECONDS);
        }
        // 跳转到登录页面
        return "redirect:/admin/login";
    }

}
