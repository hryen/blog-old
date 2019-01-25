<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">
<main>
    <article class="article">
        <h2 class="title">${article.title}</h2>
        <p class="info">
            <i class="material-icons md-18 md-dark">date_range</i>
            ${article.publishDate?string("MMM dd, yyyy")}
            <#--category-->
            <#if article.categoryName?exists>
                <i class="material-icons md-18 md-dark">folder</i>
                <a href="${request.contextPath}/category/${article.categoryName}">${article.categoryName}</a>
            </#if>
            <#--tags-->
            <#if article.tagList?exists && (article.tagList?size gt 0)>
                <i class="material-icons md-18 md-dark">local_offer</i>
                <#list article.tagList as tag>
                    <#if tag_has_next>
                        <a href="${request.contextPath}/tag/${tag.name}">${tag.name}</a>,
                    <#else>
                        <a href="${request.contextPath}/tag/${tag.name}">${tag.name}</a>
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
