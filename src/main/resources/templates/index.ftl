<#assign title = blogTitle>
<#assign description = blogDescription>
<#include "common/header.ftl">
<main>

    <#--list中第一篇文章 要么是置顶的要么是最新的-->
    <div class="first-article">
        <#if articleList[0].permalink??>
            <h2><a href="${request.contextPath}/article/${articleList[0].permalink}">${articleList[0].title}</a></h2>
        <#else>
            <h2><a href="${request.contextPath}/article/${articleList[0].id}">${articleList[0].title}</a></h2>
        </#if>
        ${articleList[0].summary}
    </div>


    <div class="content">

        <div class="articles">

            <h6>Latest articles</h6>
            <hr>

            <#list articleList as article>
                <#if article_index = 0>
                    <#continue>
                </#if>
                <div class="article">

                    <#if article.permalink??>
                        <h6 class="title"><a href="${request.contextPath}/article/${article.permalink}">${article.title}</a></h6>
                    <#else>
                        <h6 class="title"><a href="${request.contextPath}/article/${article.id}">${article.title}</a></h6>
                    </#if>

                    <p class="date">${article.publishDate?string("MMM dd, yyyy")}</p>

                    <div class="markdown-body">
                        ${article.summary}
                    </div>

                </div>
            </#list>

            <#include "common/pagination.ftl">

        </div>

        <#include "common/aside.ftl">

    </div>
</main>

<#include "common/footer.ftl">