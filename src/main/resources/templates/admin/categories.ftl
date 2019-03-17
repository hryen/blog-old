<#assign title = "分类管理">
<#assign activeMenu = "5">
<#include "common/header.ftl">

<el-container>
    <el-main>
        <#--dialog-->
        <el-dialog :title.sync="dialogTitle" :visible.sync="dialogVisible" width="30%">
            <el-form :model="form" label-width="60px">
                <el-form-item label="名称">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="描述">
                    <el-input type="textarea" rows="4" v-model="form.description"></el-input>
                </el-form-item>
            </el-form>

            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="handleSubmit">确 定</el-button>
            </span>
        </el-dialog>

        <el-row>
            <el-button icon="el-icon-refresh" size="small" @click="listCategories">刷新</el-button>
            <el-button type="primary" size="small" @click="openDialogCreate">新建</el-button>
        </el-row>

        <el-table v-loading="loading" stripe :data="tableData" tooltip-effect="dark">
            <el-table-column type="index" width="50"></el-table-column>

            <el-table-column prop="name" label="名称" show-overflow-tooltip></el-table-column>

            <el-table-column prop="description" label="描述" show-overflow-tooltip></el-table-column>

            <el-table-column prop="articleCount" label="文章数"></el-table-column>

            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" icon="el-icon-setting" @click="handleEdit(scope.row)"></el-button>
                    <el-button type="danger" size="mini" icon="el-icon-delete" @click="handleDelete(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>
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
                tableData: [],
                loading: false,
                dialogVisible: false,
                dialogTitle: '',
                form: {
                    id: null,
                    name: '',
                    description: ''
                }
            }
        },

        mounted() {
            this.listCategories();
        },

        methods: {
            openDialogCreate: function() {
                this.dialogTitle = '新建';
                this.form.id = null;
                this.form.name = '';
                this.form.description = '';
                this.dialogVisible = true;
            },

            handleEdit: function(row) {
                this.dialogTitle = '编辑';
                this.form.id = row.id;
                this.form.name = row.name;
                this.form.description = row.description;
                this.dialogVisible = true;
            },

            handleSubmit: function() {
                if (this.form.id == null) {
                    this.saveCategory();
                } else {
                    this.updateCategory();
                }
                this.dialogVisible = false;
            },

            saveCategory: function() {
                this.$axios.post('/admin/api/category/save', {
                    name: this.form.name,
                    description: this.form.description
                }).then((response) => {
                    if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });

                    // 添加成功 刷新列表
                    this.listCategories();
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });
            },

            updateCategory: function() {
                this.$axios.post('/admin/api/category/update', {
                    id: this.form.id,
                    name: this.form.name,
                    description: this.form.description
                }).then((response) => {
                    if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });

                    // 更新成功 刷新列表
                    this.listCategories();
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });
            },

            handleDelete: function(row) {
                this.$confirm('此操作不可逆，该分类下的文章将被设置成未分类，确定要删除此分类吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    // 执行删除
                    this.$axios.post('/admin/api/category/delete', {
                        id: row.id
                    }).then((response) => {
                        if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });

                    // 删除成功 刷新列表
                    this.listCategories();
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });

            });

            },

            listCategories: function() {
                this.loading = true;
                this.$axios.get('/admin/api/category/listAllCategory')
                    .then((response) => {
                    this.tableData = response.data;
                this.loading = false;
            }).catch((error) => {
                    this.loading = false;
                console.log(error);
            });
            }

        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>
</body>
</html>