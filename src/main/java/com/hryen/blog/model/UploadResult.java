package com.hryen.blog.model;

public class UploadResult {

    private boolean result;

    private String message;

    private String uri;

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

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public UploadResult(boolean result, String message, String uri) {
        this.result = result;
        this.message = message;
        this.uri = uri;
    }

    public UploadResult(boolean result, String message) {
        this.result = result;
        this.message = message;
    }
}
