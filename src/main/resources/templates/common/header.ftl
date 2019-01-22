<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/styles/tomorrow.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <link rel="stylesheet" href="${request.contextPath}/css/github-markdown.css">
    <link rel="stylesheet" href="${request.contextPath}/css/hryen.css">

    <meta charset="utf-8"/>
    <meta name="viewport" content="initial-scale=1, minimum-scale=1, width=device-width, shrink-to-fit=no"/>
    <#if description??>
    <meta name="description" content="${description}"/>
    </#if>
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
