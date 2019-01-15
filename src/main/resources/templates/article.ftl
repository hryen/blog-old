<#assign title = article.title + " | " + blogTitle>

<#include "common/header.ftl">

${article.title}
<hr>
${article.publishDate?date}
<hr>
${article.category.name}
<hr>
<#list article.tagList as tag>
    ${tag.name}
</#list>
${article.htmlContent}
