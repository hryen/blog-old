package com.hryen.blog.web.controller.admin.api;

import com.hryen.blog.model.Navigation;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiNavigationService;
import com.hryen.blog.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/api/navigation")
public class ApiNavigationController {

    @Autowired
    private CommonService commonService;

    @Autowired
    private ApiNavigationService apiNavigationService;

    @GetMapping("/list")
    public List<Navigation> listNavigation() {
        return commonService.listNavigation();
    }

    @PostMapping("/save")
    public Result save(@RequestBody Navigation navigation) {
        try {
            apiNavigationService.save(navigation);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    @PostMapping("/update")
    public Result update(@RequestBody Navigation navigation) {
        try {
            apiNavigationService.update(navigation);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    @PostMapping("/delete")
    public Result delete(@RequestBody Navigation navigation) {
        try {
            apiNavigationService.delete(navigation);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

}
