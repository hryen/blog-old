<#assign title = blogTitle>
<#assign description = blogDescription>
<#include "common/header.ftl">
<main>

    <#--置顶文章 list中第一篇文章 如果是置顶文章则显示 否则不显示-->
    <#if articleList?exists && articleList?size gt 0>
        <#if articleList[0].status == '2'>
            <div class="first-article">
            <#if articleList[0].permalink??>
                <h2><a href="${request.contextPath}/article/${articleList[0].permalink}">${articleList[0].title}</a></h2>
            <#else>
                <h2><a href="${request.contextPath}/article/${articleList[0].id}">${articleList[0].title}</a></h2>
            </#if>
            ${articleList[0].summary}
            </div>
        </#if>
    </#if>



    <div class="content">

        <div class="articles">

            <h6>Latest articles</h6>
            <hr>

            <#list articleList as article>
                <#--如果list第一篇文章是置顶文章 跳过此次遍历 因为这个文章在上面已经显示成置顶文章了-->
                <#if article_index = 0 && article.status == '2'>
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

            <#--<#include "common/pagination.ftl">-->

        </div>

        <#include "common/aside.ftl">

    </div>
</main>

<#include "common/footer.ftl">