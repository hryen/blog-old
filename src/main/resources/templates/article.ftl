<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">

<main>
    <article class="article">

        <h2 class="title">${article.title}</h2>
        <p class="info">
            ${article.publishDate?string("MMM dd, yyyy")}
            ${article.categoryName!}

            <#if article.tagList?? && article.tagList?size gt 0>
                <#list article.tagList as tag>
                    ${tag.name}
                </#list>
            </#if>
        </p>

        <div class="markdown-body">
            ${article.htmlContent}
        </div>

    </article>
</main>

<#include "common/footer.ftl">
