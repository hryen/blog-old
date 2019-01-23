package com.hryen.blog.mapper;

import com.hryen.blog.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AdminUserMapper {

    // 根据username获取user
    @Select("SELECT * FROM user WHERE username = #{username}")
    User getUserByUsername(String username);

    // 根据id获取user
    @Select("SELECT * FROM user WHERE id = #{uid}")
    User getUserById(String uid);

}
