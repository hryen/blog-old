package com.hryen.blog.web.controller.admin.api;

import com.hryen.blog.model.Comment;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/comment")
public class ApiCommentController {

    @Autowired
    private ApiCommentService apiCommentService;

    @PostMapping("/save")
    public Result save(@RequestBody Comment comment) {
        try {
            apiCommentService.save(comment);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();

            String msg = "Failed";
            if ("This article does not allow comments".equals(e.getMessage())) {
                msg = "This article does not allow comments";
            }
            return new Result(false, msg);
        }
    }

    @PostMapping("/delete")
    public Result delete(@RequestBody Comment comment) {
        try {
            apiCommentService.delete(comment);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

}
