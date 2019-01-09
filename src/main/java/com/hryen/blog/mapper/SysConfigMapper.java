package com.hryen.blog.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.PathVariable;

@Mapper
public interface SysConfigMapper {

    @Select("SELECT `value` FROM `sys_config` WHERE `variable` = #{variable}")
    String getSysConfig(String variable);

    @Update("UPDATE `sys_config` SET `value` = #{value} WHERE variable = #{variable}")
    void updateSysConfig(@PathVariable("variable") String variable, @PathVariable("value") String value);

}
