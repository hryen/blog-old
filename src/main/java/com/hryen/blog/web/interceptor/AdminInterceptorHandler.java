package com.hryen.blog.web.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AdminInterceptorHandler implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object user = request.getSession().getAttribute("user");
        if (null != user) {
            // 如果用户已登录 则放行
            return true;
        } else {
            // 如果用户未登录 跳转登录页面
            response.sendRedirect("/admin/login");
            return false;
        }
    }

}
