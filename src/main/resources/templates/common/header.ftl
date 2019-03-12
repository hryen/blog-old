<!DOCTYPE html>
<html>
<head>
    <title>${title!}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
    <link rel="stylesheet" href="${request.contextPath}/css/github-markdown.css">
    <link rel="stylesheet" href="${request.contextPath}/css/hryen.css">
    <meta charset="utf-8"/>
    <meta name="viewport" content="initial-scale=1, minimum-scale=1, width=device-width, shrink-to-fit=no"/>
    <meta name="description" content="${description!}"/>
</head>
<body>
<div class="container">
    <#--header-->
    <header class="header d-flex align-items-center">
        <div class="site-title text-center">
            <a href="${request.contextPath}/">${blogTitle!}</a>
        </div>
    </header>
    <#--navigation-->
    <nav class="nav d-flex align-items-center">
        <#list navigationList as nav>
            <a href="${nav.url}" title="${nav.title}">${nav.title}</a>
        </#list>
    </nav>
