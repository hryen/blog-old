package com.hryen.blog.mapper;

import com.hryen.blog.model.Navigation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CommonMapper {

    @Select("SELECT * FROM `navigation` ORDER BY `order`")
    List<Navigation> getNavigations();
}
