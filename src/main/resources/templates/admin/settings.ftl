<#assign title = "博客设置">
<#assign activeMenu = "5">
<#include "common/header.ftl">

            <el-container>
                <el-main>

                    <el-tabs value="blogManagement">

                        <el-tab-pane label="博客管理" name="blogManagement">
                            <el-form ref="blogManagementForm" :model="blogManagementForm" label-width="110px" style="width: 50%;">
                                <el-form-item label="博客名称">
                                    <el-input v-model="blogManagementForm.title"></el-input>
                                </el-form-item>
                                <el-form-item label="博客描述">
                                    <el-input v-model="blogManagementForm.description"></el-input>
                                </el-form-item>
                                <el-form-item label="博客所属">
                                    <el-input v-model="blogManagementForm.owner"></el-input>
                                </el-form-item>
                                <el-form-item label="首页每页文章数">
                                    <el-input-number v-model="blogManagementForm.indexPageSize"
                                                     controls-position="right" :min="1">
                                    </el-input-number>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="blogManagementFormSubmit">保存</el-button>
                                </el-form-item>
                            </el-form>
                        </el-tab-pane>

                        <el-tab-pane label="导航管理" name="navManagement">

                        </el-tab-pane>

                        <el-tab-pane label="缓存管理" name="cacheManagement">
                            <el-button @click="cleanIndexArticleListCache">清除首页文章缓存</el-button>
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
                blogManagementForm: {title: '', owner: '', description: '', indexPageSize: ''}
            }
        },

        mounted() {},

        methods: {
            blogManagementFormSubmit() {
                console.log(this.blogManagementForm);
            },

            cleanIndexArticleListCache() {
                this.$confirm('此操作将清除首页文章缓存, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.get('/admin/api/cache/cleanIndexArticleListCache')
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
