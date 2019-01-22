package com.hryen.blog.web.config;

import com.hryen.blog.web.interceptor.AdminInterceptorHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AdminWebMvcConfigure implements WebMvcConfigurer {

    @Autowired
    private AdminInterceptorHandler adminInterceptorHandler;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 拦截/admin下面所有资源 只放行/admin/login 因为login页面简陋 所以无需放行其他静态资源
        registry.addInterceptor(adminInterceptorHandler)
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/admin/login");
    }

}
