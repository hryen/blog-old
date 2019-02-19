<#assign title = "标签管理">
<#assign activeMenu = "4">
<#include "common/header.ftl">

            <el-container>
                <el-main>

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