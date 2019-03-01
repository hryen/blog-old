package com.hryen.blog.service;

import com.hryen.blog.mapper.AttachmentMapper;
import com.hryen.blog.model.Attachment;
import com.hryen.blog.model.Pagination;
import com.hryen.blog.util.Snowflake;
import com.hryen.blog.util.AttachmentUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.util.Date;
import java.util.List;

@Service
public class ApiAttachmentService {

    @Autowired
    private AttachmentMapper attachmentMapper;

    @Autowired
    private Snowflake snowflake;

    // 1.上传文件
    @Transactional
    public void save(Attachment attachment) {

        // set id
        attachment.setId(String.valueOf(snowflake.nextId()));

        // set uploaded time
        attachment.setUploaded(new Date());

        // set extension
        String name = attachment.getName();
        String extension = name.substring(name.lastIndexOf(".")+1);
        attachment.setExtension(extension);

        // set size
        attachment.setSize(AttachmentUtils.convertFileSize(Long.valueOf(attachment.getSize())));

        attachmentMapper.save(attachment);
    }

    // 2.获取文件列表 按上传日期排序 带分页
    public List<Attachment> listWithPage(Integer pageSize, Integer currentPage) {
        Pagination pagination = new Pagination(currentPage, pageSize, this.getTotalRecord());
        return attachmentMapper.listWithPage(pagination.getStartIndex(), pageSize);
    }

    // 3.根据id删除
    @Transactional
    public void delete(String id, String path) throws Exception{
        // 删除真实文件
        File resourcesDir = ResourceUtils.getFile("classpath:");
        File file = new File(resourcesDir, "static/"+path);
        boolean delete = file.delete();
        if (!delete) {
            throw new Exception("File delete failed");
        }

        // 删除数据库记录
        attachmentMapper.delete(id);
    }

    // 4.获取总记录数
    public Integer getTotalRecord() {
        return attachmentMapper.getTotalRecord();
    }

}
