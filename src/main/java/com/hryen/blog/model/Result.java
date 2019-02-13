package com.hryen.blog.model;

public class Result {

    private boolean result;

    private String message;

    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Result(boolean result, String message) {
        this.result = result;
        this.message = message;
    }
}
