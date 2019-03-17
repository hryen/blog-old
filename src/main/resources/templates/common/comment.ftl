<#if article.commentList?exists && (article.commentList?size gt 0)>
    <div class="comments">
        <p class="comments-count">${article.commentCount} Comments</p>

        <#macro listChildComments childCommentList>
            <#list childCommentList as comment>
                <div class="comment child">
                    <div class="comment-avatar">
                        <#if comment.emailMD5??>
                            <img src="https://www.gravatar.com/avatar/${comment.emailMD5}?s=48">
                        <#else>
                            <img src="${request.contextPath}/img/00000000000000000000000000000000.png">
                        </#if>
                    </div>

                    <div class="comment-content-container">
                        <#if comment.url?exists>
                        <p id="comment-${comment.id}" class="comment-author">
                            <a target="_blank" href="${comment.url}">${comment.author}</a>
                            Reply
                            <a href="#comment-${comment.parentComment.id}">@${comment.parentComment.author}</a>
                            <a class="reply" href="javascript:replyComment('${comment.id}', '${comment.author}')">REPLY</a>
                        </p>
                        <#else>
                        <p id="comment-${comment.id}" class="comment-author">
                            ${comment.author}
                            Reply
                            <a href="#comment-${comment.parentComment.id}">@${comment.parentComment.author}</a>
                            <a class="reply" href="javascript:replyComment('${comment.id}', '${comment.author}')">REPLY</a>
                            </#if>
                        <p class="comment-date">
                            ${comment.publishDate?string("MMM dd, yyyy")} at ${comment.publishDate?string("HH:mm")}
                        </p>
                        <p class="comment-content">${comment.content}</p>
                    </div>
                </div>
                <#if comment.childCommentList?exists && comment.childCommentList?size gt 0>
                    <@listChildComments comment.childCommentList></@listChildComments>
                </#if>
            </#list>
        </#macro>

        <#list article.commentList as comment>
            <div class="comment">
                <div class="comment-avatar">
                    <#if comment.emailMD5??>
                        <img src="https://www.gravatar.com/avatar/${comment.emailMD5}?s=48">
                    <#else>
                        <img src="${request.contextPath}/img/00000000000000000000000000000000.png">
                    </#if>
                </div>
                <div class="comment-content-container">
                    <#if comment.url?exists>
                        <p id="comment-${comment.id}" class="comment-author">
                            <a target="_blank" href="${comment.url}">${comment.author}</a>
                            <a class="reply" href="javascript:replyComment('${comment.id}', '${comment.author}')">REPLY</a>
                        </p>
                    <#else>
                        <p id="comment-${comment.id}" class="comment-author">
                            ${comment.author}
                            <a class="reply" href="javascript:replyComment('${comment.id}', '${comment.author}')">REPLY</a>
                        </p>
                    </#if>

                    <p class="comment-date">
                        ${comment.publishDate?string("MMM dd, yyyy")} at ${comment.publishDate?string("HH:mm")}
                    </p>
                    <p class="comment-content">${comment.content}</p>
                </div>
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
        <p style="float: left;width: 49%;">
            <input id="author" type="text" placeholder="your name (required)">
        </p>
        <p style="float: right;width: 49%;">
            <input id="email" type="email" placeholder="your email (optional, contact you and avatar)">
        </p>
        <textarea id="content" placeholder="Say something..."></textarea>
        <p><input id="url" type="url" placeholder="your website url (optional, e.g: https://www.example.com)"></p>
        <button id="submitComment" onclick="submitComment('${article.id}')">Comment</button>
        <button id="cancelReply" hidden="hidden" onclick="cancelReply()">Cancel reply</button>
    </div>
</#if>