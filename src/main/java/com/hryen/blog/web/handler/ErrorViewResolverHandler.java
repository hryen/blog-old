package com.hryen.blog.web.handler;

import com.hryen.blog.util.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class ErrorViewResolverHandler implements ErrorViewResolver {

    @Autowired
    private ControllerUtils controllerUtils;

    @Override
    public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {

        // 获取博客的 标题，描述，导航，所属者
        Map<String, Object> commonAttributes = controllerUtils.getCommonAttributes();

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addAllObjects(model);
        modelAndView.addAllObjects(commonAttributes);
        modelAndView.setViewName("error");

        return modelAndView;
    }

}
