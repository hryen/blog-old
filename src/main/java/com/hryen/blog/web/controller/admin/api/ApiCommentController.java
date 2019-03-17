package com.hryen.blog.web.controller.admin.api;

import com.hryen.blog.model.Comment;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ApiCommentController {

    @Autowired
    private ApiCommentService apiCommentService;

    @PostMapping("/api/comment/save")
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

    @PostMapping("/admin/api/comment/delete")
    public Result delete(@RequestBody Comment comment) {
        try {
            apiCommentService.delete(comment);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    @GetMapping("/admin/api/comment/listCommentsWithPage")
    public List<Comment> listCommentsWithPage(Integer pageSize, Integer currentPage) {
        if (null == pageSize || null == currentPage) { return null; }
        return apiCommentService.listCommentsWithPage(pageSize, currentPage);
    }

    @GetMapping("/admin/api/comment/getAllCommentTotalRecord")
    public Integer getAllCommentTotalRecord() {
        return apiCommentService.getAllCommentTotalRecord();
    }

}
