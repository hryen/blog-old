package com.hryen.blog;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ApplicationInitializer implements CommandLineRunner {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public void run(String... args) throws Exception {
        logger.info("init...");
    }

}