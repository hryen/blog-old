package com.hryen.blog;

import com.hryen.blog.service.ArticleService;
import com.hryen.blog.util.ArticleUtils;
import com.hryen.blog.util.PasswordUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ApplicationTests {

    @Autowired
    private PasswordUtils passwordUtils;

    @Autowired
    private ArticleService articleService;

    @Test
    public void test1() {
        System.out.println(passwordUtils.encrypt("admin"));
    }

    @Test
    public void test2() {
        System.out.println(passwordUtils.decrypt("+/sBS0Gisb4="));
    }

}
