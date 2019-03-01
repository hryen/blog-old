package com.hryen.blog.web.admin.api;

import com.hryen.blog.model.Attachment;
import com.hryen.blog.model.Result;
import com.hryen.blog.service.ApiAttachmentService;
import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin/api/attachment")
public class ApiAttachmentController {

    private static final String uploadDirName = "uploads";

    @Autowired
    private ApiAttachmentService apiAttachmentService;

    @Autowired
    private Snowflake snowflake;

    // 1.上传文件
    @PostMapping("/upload")
    public Result upload(MultipartFile[] files) {

        try {
            for (MultipartFile file : files) {
                // 获取提交的文件名称
                String originalFilename = file.getOriginalFilename();

                // 将文件重新命名
                long id = snowflake.nextId();
                String newFilename = id + "_" + originalFilename;

                // 创建目录对象 类似/upload/2019/02
                File resourcesDir = ResourceUtils.getFile("classpath:");
                File staticDir = new File(resourcesDir, "static");
                File uploadDir = new File(staticDir, uploadDirName);
                File yearDir = new File(uploadDir, new SimpleDateFormat("yyyy").format(new Date()));
                File monthDir = new File(yearDir, new SimpleDateFormat("MM").format(new Date()));

                // 如果目录不存在 则创建
                if (!monthDir.exists()) { monthDir.mkdirs(); }

                // 创建要上传的File对象
                File uploadFile = new File(monthDir, newFilename);

                // 执行上传
                file.transferTo(uploadFile);

                // 文件上传后的uri
                String uploadPath = "/"+uploadDirName+"/"+yearDir.getName()+"/"+monthDir.getName()+"/"+newFilename;

                // 保存到数据库
                apiAttachmentService.save(new Attachment(originalFilename, file.getContentType(), uploadPath, String.valueOf(file.getSize())));
            }

            return new Result(true, "Upload Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Upload Failed");
        }
    }

    // 2.获取文件列表 按上传日期排序 带分页
    @GetMapping("/listWithPage")
    public List<Attachment> listAttachmentWithPage(Integer pageSize, Integer currentPage) {
        if (null == pageSize || null == currentPage) { return null; }
        return apiAttachmentService.listWithPage(pageSize, currentPage);
    }

    // 3.根据id删除
    @PostMapping("/delete")
    public Result delete(@RequestBody Map data) {
        String id = (String) data.get("id");
        String path = (String) data.get("path");
        try {
            apiAttachmentService.delete(id, path);
            return new Result(true, "Successful");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "Failed");
        }
    }

    // 4.获取总记录数
    @GetMapping("/getTotalRecord")
    public Integer getTotalRecord() {
        return apiAttachmentService.getTotalRecord();
    }

}
