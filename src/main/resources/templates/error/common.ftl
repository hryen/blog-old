<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>${status} ${error} - ${blogTitle}</title>
    <meta name="viewport" content="initial-scale=1, minimum-scale=1, width=device-width" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
    <style>
        body {
            margin: 0 24px;
            background-color: #fafafa;
        }

        .container {
            width: auto;
            max-width: 1024px;
            margin: 0 auto;
            font-family: 'Roboto', sans-serif;
        }

        .header {
            display: flex;
            height: 63px;
            border-bottom: 1px solid #e0e0e0;
            padding: 0 24px;
            align-items: center;
        }

        .header h2 {
            flex: 1;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 400;
            line-height: 1.33;
            margin: 0;
        }

        .nav {
            justify-content: space-between;
            height: 48px;
            padding: 0 24px;
            display: flex;
            align-items: center;
        }

        .nav a {
            font-size: .875rem;
            font-weight: 400;
            line-height: 1.5;
            color: #000;
            text-decoration: none;
            letter-spacing: .01071em;
        }
        .nav a:hover {
            color: #000;
            text-decoration: underline;
        }

        .copyright {
            margin-top: 48px;
            margin-bottom: 32px;
        }

        .copyright p {
            color: rgba(0,0,0,.54);
            text-align: center;
            font-size: .875rem;
            font-weight: 400;
            line-height: 1.5;
            letter-spacing: .01071em;
        }

        .copyright a {
            color: rgba(0,0,0,.54);
            text-decoration: none;
        }

        .copyright a:hover {
            text-decoration: underline;
        }

        .content {
            display: flex;
            width: calc(100% + 40px);
            margin: -20px;
            margin-top: 200px;
            margin-bottom: 200px;
        }

        .info {
            text-align: center;
            width: 100%;
            font-weight: 400;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="header">
        <h2>${blogTitle}</h2>
    </div>
    <div class="nav">
        <#list navigationList as nav>
            <a href="${nav.url}" title="${nav.title}">${nav.title}</a>
        </#list>
    </div>

    <div class="content">
        <h1 class="info">
            ${status} - ${error}
        </h1>
    </div>

    <div class="copyright">
        <p>Build in 2019 by ${blogOwner}.</p>
    </div>
</div>

</body>
</html>