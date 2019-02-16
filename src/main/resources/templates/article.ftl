<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">
<main>
    <article class="article">
        <h2 class="title">${article.title}</h2>
        <p class="info">
            ${article.lastModifiedDate?string("MMM dd, yyyy")}

            <#--category-->
            <#if article.categoryName?exists>
                <svg class="vertical-align-text-bottom" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="rgba(0, 0, 0, 0.54)">
                    <path d="M10 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2h-8l-2-2z"/>
                    <path d="M0 0h24v24H0z" fill="none"/>
                </svg>
                <a target="_blank" href="${request.contextPath}/category/${article.categoryName}">${article.categoryName}</a>
            </#if>
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
    </article>
</main>
<#include "common/footer.ftl">
