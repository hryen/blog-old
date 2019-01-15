package com.hryen.blog.web.handler;

import com.hryen.blog.model.Navigation;
import com.hryen.blog.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class ErrorViewResolverHandler implements ErrorViewResolver {

    @Autowired
    private CommonService commonService;

    @Override
    public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
        String blogTitle = commonService.getBlogTitle();
        String blogOwner = commonService.getBlogOwner();
        List<Navigation> navigationList = commonService.getNavigation();

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addAllObjects(model);
        modelAndView.addObject("blogTitle", blogTitle);
        modelAndView.addObject("blogOwner", blogOwner);
        modelAndView.addObject("navigationList", navigationList);
        modelAndView.setViewName("common/error");

        return modelAndView;
    }

}
