<#assign title = "博客设置">
<#assign activeMenu = "5">
<#include "common/header.ftl">

            <el-container>
                <el-main>

                    <el-tabs value="blogManagement" @tab-click="handleClick">

                        <el-tab-pane label="博客管理" name="blogManagement">
                            <el-form :model="blogManagementForm" label-width="110px" style="width: 50%;">
                                <el-form-item label="博客标题">
                                    <el-input v-model="blogManagementForm.blogTitle"></el-input>
                                </el-form-item>
                                <el-form-item label="博客描述">
                                    <el-input v-model="blogManagementForm.blogDescription"></el-input>
                                </el-form-item>
                                <el-form-item label="博客所属">
                                    <el-input v-model="blogManagementForm.blogOwner"></el-input>
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
                            <el-row>
                                <el-button icon="el-icon-refresh" size="small" @click="listNavigation">刷新</el-button>
                                <el-button type="primary" size="small" @click="openDialogCreate">新建</el-button>
                            </el-row>
                            <el-table :data="navigationTableData" stripe>
                                <el-table-column type="index" width="50"></el-table-column>
                                <el-table-column prop="title" label="标题"></el-table-column>
                                <el-table-column prop="url" label="链接"></el-table-column>
                                <el-table-column prop="order" label="排序"></el-table-column>
                                <el-table-column label="操作">
                                    <template slot-scope="scope">
                                        <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
                                        <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>

                            <#--dialog-->
                            <el-dialog :title.sync="dialogTitle" :visible.sync="dialogVisible" width="40%">
                                <el-form :model="navManagementForm" label-width="60px">
                                    <el-form-item label="标题">
                                        <el-input v-model="navManagementForm.title"></el-input>
                                    </el-form-item>
                                    <el-form-item label="链接">
                                        <el-input v-model="navManagementForm.url"></el-input>
                                    </el-form-item>
                                    <el-form-item label="排序">
                                        <el-input-number v-model="navManagementForm.order"
                                                         controls-position="right" :min="1">
                                        </el-input-number>
                                    </el-form-item>
                                </el-form>
                                <span slot="footer" class="dialog-footer">
                                    <el-button @click="dialogVisible = false">取 消</el-button>
                                    <el-button type="primary" @click="handleNavManagementFormSubmit">确 定</el-button>
                                </span>
                            </el-dialog>
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
                blogManagementForm: {
                    blogTitle: '',
                    blogDescription: '',
                    blogOwner: '',
                    indexPageSize: 0
                },
                navManagementForm: {
                    id: null,
                    title: '',
                    url: '',
                    order: 0
                },
                navigationTableData: [],
                dialogVisible: false,
                dialogTitle: ''
            }
        },

        mounted() {
            this.getSysConfig();
        },

        methods: {
            openDialogCreate: function() {
                this.navManagementForm.id = null;
                this.navManagementForm.title = '';
                this.navManagementForm.url = '';
                this.navManagementForm.order = 99;
                this.dialogTitle = '新建';
                this.dialogVisible = true;
            },

            handleNavManagementFormSubmit: function() {
                if (this.navManagementForm.id == null) {
                    this.$axios.post('/admin/api/navigation/save', {
                        title: this.navManagementForm.title,
                        url: this.navManagementForm.url,
                        order: this.navManagementForm.order
                    }).then((response) => {
                        if (response.data.result) {
                        this.$message({type: 'success', message: response.data.message});
                        // 更新列表
                        this.listNavigation();
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
                } else {
                    this.$axios.post('/admin/api/navigation/update', {
                        id: this.navManagementForm.id,
                        title: this.navManagementForm.title,
                        url: this.navManagementForm.url,
                        order: this.navManagementForm.order
                    }).then((response) => {
                        if (response.data.result) {
                        this.$message({type: 'success', message: response.data.message});
                        // 更新列表
                        this.listNavigation();
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
                }
                this.dialogVisible = false;
            },

            handleEdit: function(row) {
                this.navManagementForm.id = row.id;
                this.navManagementForm.title = row.title;
                this.navManagementForm.url = row.url;
                this.navManagementForm.order = row.order;
                this.dialogTitle = '编辑';
                this.dialogVisible = true;
            },

            handleDelete: function(row) {
                this.$confirm('此操作不可逆, 是否确认删除此导航?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$axios.post('/admin/api/navigation/delete', {
                        id: row.id
                    }).then((response) => {
                        if (response.data.result) {
                            this.$message({type: 'success', message: response.data.message});
                            // 更新列表
                            this.listNavigation();
                        } else {
                            this.$message({type: 'error', message: response.data.message});
                        }
                    }).catch((error) => { console.log(error); });
                });
            },

            handleClick: function(tab, event) {
                if(tab.name == 'navManagement') {
                    this.listNavigation();
                }
            },

            listNavigation: function() {
                this.$axios.get('/admin/api/navigation/list')
                    .then((response) => {
                        this.navigationTableData = response.data;
                    });
            },

            getSysConfig: function() {
                this.$axios.get('/admin/api/sysconfig/get')
                    .then((response) => {
                        this.blogManagementForm = response.data;
                });
            },

            blogManagementFormSubmit: function () {
                this.$axios.post('/admin/api/sysconfig/update', {
                    blogTitle: this.blogManagementForm.blogTitle,
                    blogDescription: this.blogManagementForm.blogDescription,
                    blogOwner: this.blogManagementForm.blogOwner,
                    indexPageSize: this.blogManagementForm.indexPageSize
                }).then((response) => {
                    if (response.data.result) {
                        this.$message({type: 'success', message: response.data.message});
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
            },

            cleanIndexArticleListCache: function () {
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
