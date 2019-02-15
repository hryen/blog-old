package com.hryen.blog;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import java.io.File;

@Component
public class ApplicationInitializer implements CommandLineRunner {

    private Logger logger = LoggerFactory.getLogger(ApplicationInitializer.class);

    @Override
    public void run(String... args) throws Exception {

        // create upload directory
        try {
            File resourcesDir = ResourceUtils.getFile("classpath:");
            File staticDir = new File(resourcesDir, "static");
            File uploadDir = new File(staticDir, "upload");
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
                logger.info("create upload directory Successful!");
            }
        } catch (Exception e) { logger.error("create upload directory failed!"); }

    }

}
