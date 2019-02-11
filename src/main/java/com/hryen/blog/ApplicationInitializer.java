package com.hryen.blog;

import com.hryen.blog.util.RedisUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import java.io.File;

@Component
public class ApplicationInitializer implements CommandLineRunner {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RedisUtils redisUtils;

    @Override
    public void run(String... args) throws Exception {

        // 清空redis
//        try {
//            logger.info("Clear redis");
//            redisUtils.flushAll();
//        } catch (Exception e) {
//            throw new RuntimeException("Clear redis failed");
//        }


        // create upload directory
        try {
            File uploadParent = ResourceUtils.getFile("classpath:");
            File upload = new File(uploadParent, "upload");
            upload.mkdir();
            logger.info("create upload directory Successful!");
        } catch (Exception e) { logger.error("create upload directory failed!"); }

    }

}
