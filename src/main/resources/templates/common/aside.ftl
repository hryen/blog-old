<aside class="aside">

    <#--Tags-->
    <#if tagList?? && tagList?size gt 0>
        <div class="tags">
            <h6 class="title">Tags</h6>
            <#list tagList as tag>
                <span class="l${tag.level}"><a href="${request.contextPath}/tag/${tag.name}">${tag.name}</a></span>
            </#list>
        </div>
    </#if>

    <#--Contact-->
    <div style="margin-top: 24px;">
        <h6 class="title">Contact</h6>
        <p>
            <svg class="vertical-align-text-bottom" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
                <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                <path d="M0 0h24v24H0z" fill="none"/>
            </svg>
            hryen9@gmail.com
        </p>
    </div>

</aside>