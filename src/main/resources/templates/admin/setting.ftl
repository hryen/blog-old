<#assign title = "博客设置">
<#assign activeMenu = "5">
<#include "common/header.ftl">

            <el-container>
                <el-main>
                    <!-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>博客设置</el-breadcrumb-item>
                    </el-breadcrumb>

                    <el-tabs v-model="activeName">
                        <el-tab-pane label="用户管理" name="userManagement">用户管理</el-tab-pane>
                        <el-tab-pane label="缓存管理" name="cacheManagement">
                            <el-button @click="cleanArticleCache">清除所有文章缓存</el-button>
                            <el-button @click="cleanBlogSysConfigCache">清除博客设置缓存</el-button>
                        </el-tab-pane>
                    </el-tabs>
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
            return {
                activeName: 'userManagement'
            }
        },

        mounted() {},

        methods: {
            cleanArticleCache() {
                this.$confirm('此操作将清除所有文章缓存, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.get('/admin/api/cache/cleanArticleCache')
                        .then((response) => {
                            if (response.data.result) {
                                this.$message({
                                    type: 'success',
                                    message: response.data.message
                                });
                            } else {
                                this.$message({
                                    type: 'error',
                                    message: response.data.message
                                });
                            }
                        }).catch((error) => {
                            console.log(error);
                        });
            }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '操作已取消'
                    });
            });
            },

            cleanBlogSysConfigCache() {
                this.$confirm('此操作将清除所有博客设置缓存, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.get('/admin/api/cache/cleanBlogSysConfigCache')
                        .then((response) => {
                        if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });
            }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '操作已取消'
                    });
            });
            }
        }
        }

    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>

</body>
</html>
