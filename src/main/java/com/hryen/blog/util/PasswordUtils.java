package com.hryen.blog.util;

import com.hryen.blog.util.bcrypt.BCryptPasswordEncoder;

public class PasswordUtils {

    // 将字符串加密
    public static String encode(String rawPassword) {
        return new BCryptPasswordEncoder().encode(rawPassword);
    }

    // 传入字符串 和 加密过的字符串 进行对比
    // rawPassword=用户输入的密码   encodedPassword=数据库加密过的密码
    public static boolean matches(String rawPassword, String encodedPassword) {
        return new BCryptPasswordEncoder().matches(rawPassword, encodedPassword);
    }

}
