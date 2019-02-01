<#assign title = "新建文章 - 文章管理">
<#assign activeMenu = "2-1">
<#include "common/header.ftl">

			<el-container>
                <el-main>
<#-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;float: left;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>文章管理</el-breadcrumb-item>
                        <el-breadcrumb-item>新建文章</el-breadcrumb-item>
                    </el-breadcrumb>
<#--new article-->

                </el-main>
				
<#-- footer -->
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