<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        .input {
            width: 200px;
            height: 20px;
            margin: 2px 0;
        }
    </style>
</head>
<body>
<form action="${request.contextPath}/admin/login" method="post">
    <#if message??><p style="color: red;margin: 3px 0;">${message}</p></#if>
    <input class="input" type="text" name="username" placeholder="Username" autofocus>
    <br>
    <input class="input" type="password" name="password" placeholder="Password">
    <br>
    <input type="submit" value="submit">
    <input type="reset" value="reset">
</form>
</body>
</html>
