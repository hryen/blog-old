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
            <i class="material-icons black222" style="vertical-align: bottom; margin-right: 3px;">email</i>
            hryen9@gmail.com
        </p>
    </div>

</aside>