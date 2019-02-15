package com.hryen.blog;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ConfigurableApplicationContext;

@EnableCaching
@SpringBootApplication
public class Application {

    public static void main(String[] args) {

        Logger logger = LoggerFactory.getLogger(Application.class);

        ConfigurableApplicationContext run = SpringApplication.run(Application.class, args);

        String serverPort = run.getEnvironment().getProperty("server.port");

        logger.info("Application is running at http://localhost:" + serverPort);
    }

}
