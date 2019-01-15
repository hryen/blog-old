package com.hryen.blog.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

@Component
public class RedisUtils {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    // 清空所有
    public void flushAll() {
        stringRedisTemplate.getConnectionFactory().getConnection().flushAll();
    }

}
