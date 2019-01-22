<#assign title = status + " " + error + " - " + blogTitle>
<#include "common/header.ftl">

    <div class="content">
        <h1 style="text-align: center;width: 100%;font-weight: 400;margin: 200px">${status} - ${error}</h1>
    </div>

    <footer class="footer">
        <p class="text-center">&copy; ${.now?string("yyyy")} by ${blogOwner}.</p>
    </footer>
</div> <#-- /container -->

</body>
</html>
