package com.hryen.blog.mapper;

import com.hryen.blog.model.Attachment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface AttachmentMapper {


    // 保存
    @Insert("INSERT INTO attachment(id, name, type, path, uploaded, extension, size)" +
            "VALUES" +
            "(#{attachment.id}, #{attachment.name}, #{attachment.type}, #{attachment.path}," +
            "#{attachment.uploaded}, #{attachment.extension}, #{attachment.size})")
    void save(@Param("attachment") Attachment attachment);

    // 获取 按上传日期排序 带分页
    @Select("SELECT * FROM attachment ORDER BY uploaded DESC LIMIT #{startIndex},#{pageSize}")
    List<Attachment> listWithPage(@Param("startIndex") Integer startIndex, @Param("pageSize") Integer pageSize);

    // 获取总记录数
    @Select("SELECT COUNT(0) FROM attachment")
    Integer getTotalRecord();

    // 删除
    @Delete("DELETE FROM attachment WHERE id=#{id}")
    void delete(String id);

}
