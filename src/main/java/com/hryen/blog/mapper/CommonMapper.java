package com.hryen.blog.mapper;

import com.hryen.blog.model.Navigation;
import org.apache.ibatis.annotations.*;
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
    @Select("SELECT * FROM navigation ORDER BY `order`")
    List<Navigation> listNavigation();

    // 新建导航
    @Insert("INSERT INTO navigation(`id`, `title`, `url`, `order`)" +
            "VALUES (#{nav.id}, #{nav.title}, #{nav.url}, #{nav.order})")
    void saveNavigation(@Param("nav") Navigation nav);

    // 更新导航
    @Update("UPDATE navigation SET title=#{nav.title}, url=#{nav.url}, `order`=#{nav.order} WHERE id=#{nav.id}")
    void updateNavigation(@Param("nav") Navigation nav);

    // 删除导航
    @Delete("DELETE FROM navigation WHERE id=#{id}")
    void deleteNavigation(String id);
}
