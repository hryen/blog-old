package com.hryen.blog.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

// 附件数据模型
public class Attachment implements Serializable {

    private static final long serialVersionUID = -2054237856580239323L;

    // id
    private String id;

    // 文件名
    private String name;

    // 类型
    private String type;

    // 路径
    private String path;

    // 上传时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date uploaded;

    // 扩展名
    private String extension;

    // 大小
    private String size;

    public Attachment(String name, String type, String path, String size) {
        this.name = name;
        this.type = type;
        this.path = path;
        this.size = size;
    }

    public Attachment(String id, String name, String type, String path, Date uploaded, String extension, String size) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.path = path;
        this.uploaded = uploaded;
        this.extension = extension;
        this.size = size;
    }

    public Attachment() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Date getUploaded() {
        return uploaded;
    }

    public void setUploaded(Date uploaded) {
        this.uploaded = uploaded;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    @Override
    public String toString() {
        return "Attachment{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", path='" + path + '\'' +
                ", uploaded=" + uploaded +
                ", extension='" + extension + '\'' +
                ", size='" + size + '\'' +
                '}';
    }
}
