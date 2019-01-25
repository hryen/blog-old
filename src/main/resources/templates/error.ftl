<#assign title = status + " " + error + " - " + blogTitle>
<#include "common/header.ftl">

    <main>
        <h1 class="error-info text-center">${status} - ${error}</h1>
    </main>

    <footer class="footer">
        <p class="text-center">&copy; ${.now?string("yyyy")} by ${blogOwner}.</p>
    </footer>
</div> <#-- /container -->

</body>
</html>
