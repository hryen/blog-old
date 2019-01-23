package com.hryen.blog.model;

import java.io.Serializable;

public class User implements Serializable {

    private static final long serialVersionUID = 7367958883735626982L;

    private String id;

    private String username;

    private String password;

    private String mail;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }
}
