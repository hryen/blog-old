package com.hryen.blog.mapper;

import com.hryen.blog.model.Navigation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Mapper
public interface CommonMapper {

    // 获取博客设置项
    @Select("SELECT `value` FROM `sys_config` WHERE `variable` = #{variable}")
    String getSysConfig(String variable);

    // 更新博客设置项
    @Update("UPDATE `sys_config` SET `value` = #{value} WHERE variable = #{variable}")
    void updateSysConfig(@PathVariable("variable") String variable, @PathVariable("value") String value);

    // 获取导航list 根据order排序
    @Select("SELECT * FROM `navigation` ORDER BY `order`")
    List<Navigation> getNavigations();
}
