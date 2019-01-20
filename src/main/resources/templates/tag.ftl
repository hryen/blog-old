<#assign title = "Tag: " + tagName + " | " + blogTitle>
<#assign description = title>
<#include "common/header.ftl">

<main>

    <div class="content">

        <div class="articles">

            <h6>Tag: ${tagName}</h6>
            <hr>

            <#list articleList as article>
                <div class="article">
                    <h6 class="title"><a href="${request.contextPath}/article/${article.id}">${article.title}</a></h6>
                    <p class="date">${article.publishDate?string("MMM dd, yyyy")}</p>
                    ${article.summary}
                </div>
            </#list>

            <#include "common/pagination.ftl">

        </div>

        <#include "common/aside.ftl">

    </div>
</main>

<#include "common/footer.ftl">