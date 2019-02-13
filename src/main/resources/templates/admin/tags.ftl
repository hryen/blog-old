<#assign title = "标签管理">
<#assign activeMenu = "4">
<#include "common/header.ftl">

            <el-container>
                <el-main>
                    <!-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>标签管理</el-breadcrumb-item>
                    </el-breadcrumb>

                </el-main>

                <!-- footer -->
                <#include "common/footer.ftl">
            </el-container>
        </el-container>
    </el-container>


</div>



<script>
    Vue.prototype.$axios = axios.create({ baseURL: '${request.contextPath}' });

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