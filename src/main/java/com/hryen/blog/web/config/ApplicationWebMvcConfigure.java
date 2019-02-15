package com.hryen.blog.web.config;

import com.hryen.blog.web.interceptor.AdminInterceptorHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ApplicationWebMvcConfigure implements WebMvcConfigurer {

    @Autowired
    private AdminInterceptorHandler adminInterceptorHandler;

    // 注册拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 拦截/admin下面所有资源 只放行/admin/login
        registry.addInterceptor(adminInterceptorHandler)
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/admin/login");
    }

    // 注册resources目录
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 将jar包同级目录下的resources目录注册到classpath根目录
        registry.addResourceHandler("/")
                .addResourceLocations("classpath:");
    }

}
