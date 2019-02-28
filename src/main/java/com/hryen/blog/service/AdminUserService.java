package com.hryen.blog.service;

import com.hryen.blog.mapper.AdminUserMapper;
import com.hryen.blog.model.User;
import com.hryen.blog.util.PasswordUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminUserService {

    @Autowired
    private AdminUserMapper adminUserMapper;

    // 根据用户名密码进行登录 如果成功 返回该用户 如果失败 返回null
    public User login(String username, String password) {

        // 根据用户名从数据库获取该用户
        User user = adminUserMapper.getUserByUsername(username);

        // 如果用户不存在 返回null
        if (null == user) {
            return null;
        }

        // 将用户输入的密码与数据库获得的密码进行匹配
        boolean login = PasswordUtils.matches(password, user.getPassword());

        // 如果密码与数据库匹配成功 返回该用户 否则返回null
        if (login) {
            return user;
        } else {
            return null;
        }

    }

    public User getUserById(String id) {
        return adminUserMapper.getUserById(id);
    }

}
