<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">
<main>
    <article class="article">
        <h2 class="title">${article.title}</h2>
        <p class="info">
            ${article.lastModifiedDate?string("MMM dd, yyyy")}

            <#--category-->
            <svg class="vertical-align-text-bottom" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="rgba(0, 0, 0, 0.54)">
                <path d="M10 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-8l-2-2z"/>
                <path d="M0 0h24v24H0z" fill="none"/>
            </svg>
            <a target="_blank" href="${request.contextPath}/category/${article.category.name}">${article.category.name}</a>

            <#--tags-->
            <#if article.tagList?exists && (article.tagList?size gt 0)>
                <svg class="vertical-align-text-bottom" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="rgba(0, 0, 0, 0.54)">
                    <path d="M0 0h24v24H0z" fill="none"/>
                    <path d="M21.41 11.58l-9-9C12.05 2.22 11.55 2 11 2H4c-1.1 0-2 .9-2 2v7c0 .55.22 1.05.59 1.42l9 9c.36.36.86.58 1.41.58.55 0 1.05-.22 1.41-.59l7-7c.37-.36.59-.86.59-1.41 0-.55-.23-1.06-.59-1.42zM5.5 7C4.67 7 4 6.33 4 5.5S4.67 4 5.5 4 7 4.67 7 5.5 6.33 7 5.5 7z"/>
                </svg>
                <#list article.tagList as tag>
                    <#if tag_has_next>
                        <a target="_blank" href="${request.contextPath}/tag/${tag.name}">${tag.name}</a>,
                    <#else>
                        <a target="_blank" href="${request.contextPath}/tag/${tag.name}">${tag.name}</a>
                    </#if>
                </#list>
            </#if>
        </p>
        <div class="markdown-body">
            ${article.htmlContent}
        </div>

        <#if article.commentList?exists && (article.commentList?size gt 0)>
            <div class="comments">
                <p style="margin-left: -20px;">${article.commentCount} Comments</p>

                <#macro listChildComments childCommentList>
                    <#list childCommentList as comment>
                        <div class="comment child">
                            <#if comment.url?exists>
                                <p id="comment-${comment.id}" style="color: #555;font-size: 14px;">
                                    <a href="${comment.url}">${comment.author}</a> Reply <a href="#comment-${comment.parentComment.id}">@${comment.parentComment.author}</a>
                                </p>
                            <#else>
                                <p id="comment-${comment.id}" style="color: #555;font-size: 14px;">${comment.author} Reply <a href="#comment-${comment.parentComment.id}">@${comment.parentComment.author}</a>
                            </#if>
                            <p style="color: #999;font-size: 11px;">
                                ${comment.publishDate?string("MMM dd, yyyy")} at ${comment.publishDate?string("HH:mm")}
                            </p>
                            <p style="font-size: 14px;color: #333;">${comment.content}</p>
                            <p><a class="reply" href="javascript:reply('${comment.id}', '${comment.author}')">REPLY</a></p>
                        </div>
                        <#if comment.childCommentList?exists && comment.childCommentList?size gt 0>
                            <@listChildComments comment.childCommentList></@listChildComments>
                        </#if>
                    </#list>
                </#macro>

                <#list article.commentList as comment>
                    <div class="comment">
                        <#if comment.url?exists>
                            <p id="comment-${comment.id}" style="color: #555;font-size: 14px;"><a href="${comment.url}">${comment.author}</a></p>
                        <#else>
                            <p id="comment-${comment.id}" style="color: #555;font-size: 14px;">${comment.author}</p>
                        </#if>

                        <p style="color: #999;font-size: 11px;">
                            ${comment.publishDate?string("MMM dd, yyyy")} at ${comment.publishDate?string("HH:mm")}
                        </p>
                        <p style="font-size: 14px;color: #333;">${comment.content}</p>
                        <p><a class="reply" href="javascript:reply('${comment.id}', '${comment.author}')">REPLY</a></p>
                    </div>
                    <#if comment.childCommentList?exists && comment.childCommentList?size gt 0>
                        <@listChildComments comment.childCommentList></@listChildComments>
                    </#if>
                </#list>

            </div>
        </#if>

        <#if article.commentStatus>
            <div id="comment-form" class="comment-form">
                <p style="margin-bottom: 0;">Leave a Comment</p>
                <p style="float: left;width: 49%;"><input id="author" type="text" placeholder="your name (required)"></p>
                <p style="float: right;width: 49%;"><input id="email" type="email" placeholder="your email (required)"></p>
                <textarea id="content" placeholder="Say something..."></textarea>
                <p><input id="url" type="url" placeholder="your website url (optional, e.g: https://www.example.com)"></p>
                <button id="submitComment" onclick="submitComment()">Comment</button>
                <button id="cancelReply" hidden="hidden" onclick="cancelReply()">Cancel reply</button>
            </div>
        </#if>

        <style>
            .comments {
                padding-left: 20px;
                margin-bottom: 20px;
            }
            .comments a {
                text-decoration: none;
                color: #555;
            }
            .comments a:hover {
                text-decoration: underline;
            }
            .comment {
                padding-bottom: 5px;
            }
            .comment p {
                margin: 10px 0;
            }
            .child {
                margin-left: 30px;
            }
            .reply {
                font-size: 14px;
                color: #000;
                text-decoration: none;
            }
            .reply:hover {
                text-decoration: underline;
            }
            .comment-form * {
                box-sizing: border-box;
            }
            .comment-form textarea, .comment-form input {
                width: 100%;
                border: #e0e0e0 solid 1px;
                border-radius: 3px;
                padding: 10px;
                font-family: "Roboto", "Helvetica", "Arial", sans-serif;
                color: #888;
                font-size: 14px;
            }
            .comment-form textarea:focus, .comment-form input:focus {
                outline: none;
                color: #333;
            }
            .comment-form textarea {
                resize: none;
                height: 200px;
            }
            .comment-form button {
                border-radius: 3px;
                background-color: #fff;
                color: #000;
                border: 1px solid #555;
                padding: 10px 30px;
                text-align: center;
                cursor: pointer;
                outline: none;
            }
            .comment-form button:hover {
                background-color: #555;
                color: #fff;
            }
        </style>
    </article>
</main>
<script>
    var parentId = null;

    function submitComment() {
        var contentTextarea = document.getElementById('content');

        var comment = new Object();
        comment.articleId = '${article.id}';
        comment.content = contentTextarea.value.replace(/\r\n/g, '<br/>').replace(/\n/g, '<br/>').replace(/\s/g, ' ');
        comment.author = document.getElementById('author').value;
        comment.email  = document.getElementById('email').value;
        comment.url  = document.getElementById('url').value;
        if (null != parentId) {
            comment.parentId = parentId;
        }

        if (null == comment.author || "" === comment.author.trim()) {
            document.getElementById('author').focus();
            return;
        }

        if (null == comment.email || "" === comment.email.trim()) {
            document.getElementById('email').focus();
            return;
        }

        if (null == comment.content || "" === comment.content.trim()) {
            document.getElementById('content').focus();
            return;
        }

        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("POST", "/api/comment/save", true);
        xmlhttp.setRequestHeader("Content-type","application/json");

        xmlhttp.send(JSON.stringify(comment));

        xmlhttp.onreadystatechange = function() {
            if(xmlhttp.readyState==4 && xmlhttp.status==200) {
                var result = JSON.parse(xmlhttp.responseText);
                if(result.result) {
                    window.location.reload();
                    contentTextarea.value="";
                } else {
                    console.log('评论失败');
                }
            }
        }
    }

    function reply(id, author) {
        document.getElementById('submitComment').innerText = 'Reply @' + author;
        document.getElementById('cancelReply').removeAttribute('hidden');
        parentId = id;
        window.location = "#comment-form";
    }

    function cancelReply() {
        document.getElementById('cancelReply').setAttribute('hidden', 'true');
        document.getElementById('submitComment').innerText = 'Comment';
        parentId = null;
    }
</script>
<#include "common/footer.ftl">
