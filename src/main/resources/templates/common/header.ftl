<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>${title}</title>
    <meta name="description" content="${blogDescription}"/>
    <meta name="viewport" content="initial-scale=1, minimum-scale=1, width=device-width"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
    <link rel="stylesheet" href="${request.contextPath}/css/index.css">
</head>

<body id="body">
<div class="container">

    <div class="header">
        <h2>${blogTitle}</h2>
        <img class="mobile-nav-menu" src="${request.contextPath}/img/baseline-menu-24px.svg" onclick="openMobileNav()" />
    </div>

    <div class="nav">
        <#list navigationList as nav>
            <a href="${nav.url}" title="${nav.title}">${nav.title}</a>
        </#list>
    </div>
