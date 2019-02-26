package com.hryen.blog.web.admin.api;

import com.hryen.blog.util.Snowflake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin/api")
public class ApiUploadController {

    @Autowired
    private Snowflake snowflake;

    // 上传文件
    @PostMapping("/upload")
    public Map upload(MultipartFile[] files) {
        Map resultMap = new LinkedHashMap();

        try {
            ArrayList<String> uriList = new ArrayList<>();

            for (MultipartFile file : files) {
                // 获取提交的文件名称
                String originalFilename = file.getOriginalFilename();

                // 将文件重新命名
                long id = snowflake.nextId();
                String newFilename = id + "_" + originalFilename;

                // 创建目录对象 类似/upload/2019/02
                File resourcesDir = ResourceUtils.getFile("classpath:");
                File staticDir = new File(resourcesDir, "static");
                File uploadDir = new File(staticDir, "uploads");
                File yearDir = new File(uploadDir, new SimpleDateFormat("yyyy").format(new Date()));
                File monthDir = new File(yearDir, new SimpleDateFormat("MM").format(new Date()));

                // 如果目录不存在 则创建
                if (!monthDir.exists()) { monthDir.mkdirs(); }

                // 创建要上传的File对象
                File uploadFile = new File(monthDir, newFilename);

                // 执行上传
                file.transferTo(uploadFile);

                // 文件上传后的uri
                String uploadFileUri = "/uploads/"+yearDir.getName()+"/"+monthDir.getName()+"/"+newFilename;

                uriList.add(uploadFileUri);
            }

            resultMap.put("result", true);
            resultMap.put("message", "Upload Successful");
            resultMap.put("uriList", uriList);
            return resultMap;
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("result", false);
            resultMap.put("message", "Upload Failed");
            return resultMap;
        }
    }

}
