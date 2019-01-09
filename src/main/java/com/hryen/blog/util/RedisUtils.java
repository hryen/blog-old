package com.hryen.blog.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

@Component
public class RedisUtils {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    public void delKeys(String ...keys) {
//        Jedis jedis = jedisPool.getResource();
//        for (String key : keys) {
//            jedis.expire(key, 60*60*24*7);
//        }
//        jedis.close();
    }

    public void flushAll() {
//        Jedis jedis = jedisPool.getResource();
//        jedis.flushAll();
//        jedis.close();
    }


}
