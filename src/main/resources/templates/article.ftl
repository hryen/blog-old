<#assign title = article.title + " | " + blogTitle>
<#assign description = article.title>
<#include "common/header.ftl">

<main>

    <div class="content">

        <article>
                    <h3 class="title">${article.title}</h3>
                    <p class="date">
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
                    ${article.htmlContent}
        </article>

    </div>
</main>
<#include "common/footer.ftl">
