<#assign title = "附件管理">
<#assign activeMenu = "3">
<#include "common/header.ftl">

<el-container>
    <el-main>
        <#--dialogUpload-->
        <el-dialog title="上传" :visible.sync="dialogUploadVisible">
            <el-upload ref="upload" action="/admin/api/attachment/upload" name="files" multiple :limit="10"
                       :auto-upload="false" :file-list="fileList" :on-success="handleReload">

                <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
                <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传到服务器</el-button>
                <div slot="tip" class="el-upload__tip">最多选择10个文件，且不超过30MB</div>
            </el-upload>
        </el-dialog>

        <#--dialogImagePreview-->
        <el-dialog title="预览" :visible.sync="dialogImagePreviewVisible" center top="3%">
            <el-row style="text-align: center;">
                <img style="max-width: 100%;max-height: 100%;" :src="imagePreview.src">
            </el-row>

            <el-row style="text-align: center;"><span>{{ imagePreview.name }}</span></el-row>
        </el-dialog>

        <el-row>
            <el-button icon="el-icon-refresh" size="mini" @click="handleReload">刷新</el-button>
            <el-button type="primary" icon="el-icon-upload" size="mini" @click="openDialogUpload">上传</el-button>
        </el-row>

        <el-table v-loading="loading" stripe :data="tableData"
                  :default-sort="{prop: 'uploaded', order: 'descending'}"
                  tooltip-effect="dark" style="width: 100%">
            <el-table-column type="index" width="50"></el-table-column>

            <el-table-column prop="name" label="名称" width="200" show-overflow-tooltip sortable></el-table-column>

            <el-table-column prop="type" label="类型" width="200" show-overflow-tooltip sortable>
                <template slot-scope="scope">
                    <el-button v-if="scope.row.type.indexOf('image') != -1"
                               style="margin-right: 5px;"
                               size="mini" icon="el-icon-view" circle @click="handlePreview(scope.row)"></el-button>

                    <el-button v-else
                               style="margin-right: 5px;"
                               size="mini" icon="el-icon-view" circle disabled></el-button>
                    <span>{{ scope.row.type }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="path" label="URL" min-width="420" show-overflow-tooltip>
                <template slot-scope="scope">
                    <el-button size="mini" icon="el-icon-document" circle @click="handleCopyURL(scope.row.path)"></el-button>
                    <span style="margin-left: 5px;">{{ scope.row.path }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="uploaded" width="200" label="上传时间" show-overflow-tooltip sortable></el-table-column>
            <el-table-column prop="extension" width="100" label="扩展名" show-overflow-tooltip sortable></el-table-column>
            <el-table-column prop="size" width="100" label="大小"></el-table-column>


            <el-table-column label="操作" width="200">
                <template slot-scope="scope">
                    <el-button size="mini" type="danger" icon="el-icon-delete" circle @click="handleDelete(scope.row)"></el-button>
                </template>
            </el-table-column>
        </el-table>

        <el-pagination prev-text="上一页" next-text="下一页" style="margin-top: 10px;"
                       @size-change="handleSizeChange" @current-change="handleCurrentChange"
                       layout="total, sizes, prev, pager, next, jumper"
                       :total.sync="total" :page-size.sync="pageSize" :current-page.sync="currentPage">
        </el-pagination>
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
                loading: false,
                pageSize: 10,
                currentPage: 1,
                total: 0,
                dialogUploadVisible: false,
                dialogImagePreviewVisible: false,
                imagePreview: {
                    name: '',
                    src: ''
                },
                fileList: [],
                tableData: []
            }
        },

        mounted() {
            this.handleReload();
        },

        methods: {
            handlePreview: function(row) {
                this.imagePreview.src = row.path;
                this.imagePreview.name = row.name;
                this.dialogImagePreviewVisible = true;
            },

            handleCopyURL: function(path) {
                var oInput = document.createElement('input');
                oInput.value = path;
                document.body.appendChild(oInput);
                oInput.select(); // 选择对象
                document.execCommand("Copy"); // 执行浏览器复制命令
                oInput.className = 'oInput';
                oInput.style.display='none';
                this.$message('复制成功');
            },

            listAttachmentWithPage: function() {
                this.loading = true;
                this.$axios.get('/admin/api/attachment/listWithPage', {
                    params: {
                        currentPage: this.currentPage,
                        pageSize: this.pageSize
                    }
                }).then((response) => {
                    this.tableData = response.data;
                    this.loading = false;
                }).catch((error) => {
                    this.loading = false;
                    console.log(error);
                });
            },

            getTotalRecord: function() {
                this.$axios.get('/admin/api/attachment/getTotalRecord')
                    .then((response) => {
                        this.total = response.data;
                    }).catch((error) => { console.log(error); });
            },

            handleDelete: function(row) {
                this.$confirm('此操作不可逆，确定要删除此附件吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                // 执行删除
                this.$axios.post('/admin/api/attachment/delete', {
                        id: row.id,
                        path: row.path
                }).then((response) => {
                    if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });

                    // 删除成功 刷新列表
                    this.handleReload();
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });

            });

            },

            submitUpload() { this.$refs.upload.submit(); },

            openDialogUpload :function () {
                this.fileList = [];
                this.dialogUploadVisible = true;
            },

            handleSizeChange: function () { this.handleReload(); },

            handleCurrentChange: function () { this.handleReload(); },

            handleReload: function () {
                this.listAttachmentWithPage();
                this.getTotalRecord();
            }
        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>
</body>
</html>