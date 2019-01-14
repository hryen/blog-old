<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="${request.contextPath}/admin/login" method="post">
            Username: <input type="text" name="username">
            Password: <input type="password" name="password">
            <input type="submit" value="submit">
            <input type="reset" value="reset">
        </form>
    </body>
</html>
