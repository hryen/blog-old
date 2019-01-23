<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">

<main style="margin-top: 20px;">
    <article style="max-width: 100%; margin: 0 auto;padding: 0 24px;">

                <h2 class="title">${article.title}</h2>
                <p class="info">
                    ${article.publishDate?string("MMM dd, yyyy")}

                    <#if article.categoryName??>
                        ${article.categoryName}
                    </#if>

                    <#if article.tagList?? && article.tagList?size gt 0>
                        <#list article.tagList as tag>
                            ${tag.name}
                        </#list>
                    </#if>
                </p>

            <div class="markdown-body" style="max-width: 96%;margin: 0 auto;">
            ${article.htmlContent}
        </div>

    </article>
</main>

<#include "common/footer.ftl">
