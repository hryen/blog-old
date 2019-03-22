<#assign title = status + " " + error + " - " + blogTitle>
<#include "common/header.ftl">

    <main>
        <h1 class="error-info text-align-center">${status} - ${error}</h1>
    </main>

</div> <#-- /container -->

<footer class="footer">
    <p class="copy text-align-center">&copy; ${.now?string("yyyy")} by ${blogOwner!}.</p>
</footer>

</body>
</html>
