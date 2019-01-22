package com.hryen.blog.web.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class AdminInterceptorHandler implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 如果用户未登录 返回401
        Object user = request.getSession().getAttribute("user");
        if (null == user) {
            response.sendError(401);
            return false;
        }
        // 如果用户已登录 则放行
        return true;
    }

}
