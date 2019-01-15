<#--如果页数大于1 才显示分页div-->
<#if pagination.totalPage gt 1>
<div class="pagination">
    <#--如果当前页大于第一页 那么一定显示第一页和上一页-->
    <#if (pagination.pageNumber gt 1)>
        <a href="?page=1">First</a>
        <a href="?page=${pagination.pageNumber -1}">Previous</a>
    </#if>

    <#--如果当前页码<=3   最多显示到第5页-->
    <#if pagination.pageNumber lte 3>
        <#list 1..pagination.totalPage as i>
        <#--索引不小于5 退出循环-->
            <#if i_index lt 5>
                <#-- 当前页去掉超链接样式 -->
                <#if i == pagination.pageNumber>
        <span class="currentPageNumber">${i}</span>
                <#else>
        <a href="?page=${i}">${i}</a>
                </#if>
            <#else>
                <#break>
            </#if>
        </#list>

    <#--如果当前页码>3   显示往前2页和往后2页-->
    <#else>
        <#--如果总页码-当前页码<=2-->
        <#if pagination.totalPage-pagination.pageNumber lte 2>
            <#list pagination.totalPage-4..pagination.totalPage as i>
                <#--如果当前页码减去4 比0小 跳过此次循环 一定要从1开始遍历-->
                <#if i lt 1>
                    <#continue>
                </#if>
                <#-- 当前页去掉超链接样式 -->
                <#if i == pagination.pageNumber>
        <span class="currentPageNumber">${i}</span>
                <#else>
        <a href="?page=${i}">${i}</a>
                </#if>
            </#list>
        <#else>
            <#list pagination.pageNumber-2..pagination.pageNumber+2 as i>
                <#-- 当前页去掉超链接样式 -->
                <#if i == pagination.pageNumber>
        <span class="currentPageNumber">${i}</span>
                <#else>
        <a href="?page=${i}">${i}</a>
                </#if>
            </#list>
        </#if>
    </#if>

    <#--如果当前页小于最后一页 那么一定显示下一页和最后一页-->
    <#if (pagination.pageNumber lt pagination.totalPage)>
        <a href="?page=${pagination.pageNumber + 1}">Next</a>
        <a href="?page=${pagination.totalPage}">Last (${pagination.totalPage})</a>
    </#if>
    <input id="jumpPageInput" type="number" min="1" name="page">
    <button class="jumpPage" type="submit" onclick="jumpPage()">Go</button>
    <div class="clearfix"></div>
</div>
</#if>