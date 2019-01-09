package com.hryen.blog.web.handler;

import freemarker.core.Environment;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

import java.io.IOException;
import java.io.Writer;

public class FreemarkerExceptionHandler implements TemplateExceptionHandler {

    @Override
    public void handleTemplateException(TemplateException te, Environment env, Writer out) throws TemplateException {
        try {
            out.write("Error");
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
