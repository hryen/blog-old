<#assign title = "首页">
<#assign active = "1">
<#include "common/header.ftl">

            <el-container>
                <el-main>
                    <!-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;float: left;">
                        <el-breadcrumb-item>首页</el-breadcrumb-item>
                    </el-breadcrumb>

                </el-main>

                <!-- footer -->
                <#include "common/footer.ftl">
            </el-container>
        </el-container>
    </el-container>


</div>



<script>
    Vue.prototype.$axios = axios.create({ baseURL: '${request.contextPath}/' });

    var Main = {
        data() {
            return {}
        },

        mounted() {},

        methods: {}
        }

    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>

</body>
</html>