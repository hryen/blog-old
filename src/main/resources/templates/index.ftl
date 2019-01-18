<#assign title = blogTitle>
<#include "common/header.ftl">

<main>

    <div class="first-article">
        <h2><a href="article.html">扩展卡尔曼滤波怎么加自适应？</a></h2>
        <p>扩展卡尔曼滤波怎么加自适应？这是个扩展卡尔曼改进算法里面最简单最实用的做法，这个自适应三个字具体怎么理解？</p>
        <p>
            我发现很多人还有误区，最后把卡尔曼滤波整没了，特别是锂电池中，因为状态方程中有一个是AH积分法定义式，最终变成本质是AH积分法。为什么，理论理解不透彻。接下来，博主将给你们构建一下自适应扩展卡尔曼滤波算法的框架。</p>
        <p>在开发过程中，由于技术的不断迭代，为了提高开发效率，需要对原有项目的架构做出相应的调整。</p>
    </div>

    <div class="content">

        <div class="articles">

            <h6>Latest articles</h6>
            <hr>

            <#list articleList as article>
                <div class="article">
                    <h6 class="title"><a href="${request.contextPath}/article/${article.id}">${article.title}</a></h6>
                    <p class="date">${article.publishDate?string("MMM dd, yyyy")}</p>
                    ${article.summary}
                </div>
            </#list>

            <#include "common/pagination.ftl">

        </div>


        <aside class="aside">

            <div class="tags">
                <h6 class="title">Tags</h6>
                <span class="l1"><a href="#">windows</a></span>
                <span class="l3"><a href="#">penatibus</a></span>
                <span class="l2"><a href="#">magnis</a></span>
                <span class="l4"><a href="#">faucibus</a></span>
                <span class="l3"><a href="#">Duis</a></span>
                <span class="l5"><a href="#">non</a></span>
                <span class="l6"><a href="#">luctus</a></span>
                <span class="l6"><a href="#">natoque</a></span>
                <span class="l5"><a href="#">Vivamus</a></span>
                <span class="l6"><a href="#">Cum</a></span>
                <span class="l4"><a href="#">April</a></span>
                <span class="l3"><a href="#">blog</a></span>
                <span class="l1"><a href="#">natoque</a></span>
                <span class="l2"><a href="#">Vivamus</a></span>
                <span class="l3"><a href="#">Cum</a></span>
                <span class="l2"><a href="#">sociis</a></span>
                <span class="l4"><a href="#">April</a></span>
                <span class="l5"><a href="#">blog</a></span>
            </div>

            <div style="margin-top: 24px;">
                <h6 class="title">Contact</h6>
                <p><img src="img/baseline-email-24px.svg" height="21px" width="21px"
                        style="vertical-align: -0.429em; margin-right: 3px;"/>hryen9@gmail.com</p>
            </div>

        </aside>

    </div>
</main>


<footer class="footer">
    <p id="copyright" class="text-center">by Henry.</p>
</footer>
</div>

<div id="backtotop">
    <a href="javascript:backToTop();" title="Back to top"><i class="backtotop-ico"></i></a>
</div>
<script src="${request.contextPath}/js/hryen.js"></script>
</body>
</html>