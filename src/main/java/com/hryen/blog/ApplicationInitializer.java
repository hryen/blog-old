package com.hryen.blog;

import com.hryen.blog.util.RedisUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ApplicationInitializer implements CommandLineRunner {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RedisUtils redisUtils;

    @Override
    public void run(String... args) throws Exception {

        // 清空redis
        try {
            logger.info("Clear redis");
            redisUtils.flushAll();
        } catch (Exception e) {
            throw new RuntimeException("Clear redis failed");
        }

    }

}
