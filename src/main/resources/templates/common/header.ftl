<!DOCTYPE html>
<html>
    <head>
        <title>${title}</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400" rel="stylesheet">
        <link href="${request.contextPath}/css/hryen.css" rel="stylesheet">
        <meta charset="utf-8" />
        <#if description??>
        <meta name="description" content="${description}" />
        </#if>
        <meta name="viewport" content="initial-scale=1, minimum-scale=1, width=device-width, shrink-to-fit=no" />
    </head>
    <body>
        <div class="container">
            <header class="header d-flex align-items-center">
                <div class="site-title text-center">
                    <a href="${request.contextPath}/">${blogTitle}</a>
                </div>
            </header>
            <nav class="nav d-flex align-items-center">
                <#list navigationList as nav>
                <a href="${nav.url}" title="${nav.title}">${nav.title}</a>
                </#list>
            </nav>