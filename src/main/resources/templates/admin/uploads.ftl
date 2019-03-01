<#assign title = "附件管理">
<#assign activeMenu = "3">
<#include "common/header.ftl">

<el-container>
    <el-main>
        <#--dialogUpload-->
        <el-dialog title="上传" :visible.sync="dialogUploadVisible">
            <el-upload ref="upload"
                       action="/admin/api/attachment/upload"
                       name="files"
                       multiple
                       :limit="10"
                       :auto-upload="false"
                       :file-list="fileList">
            <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
            <el-button style="margin-left: 10px;" size="small" type="success" @click="submitUpload">上传到服务器</el-button>
            <div slot="tip" class="el-upload__tip">最多选择10个文件，且不超过30MB</div>
            </el-upload>
        </el-dialog>



        <el-row>
            <el-button icon="el-icon-refresh" size="mini" @click="listAttachmentWithPage">刷新</el-button>
            <el-button type="primary" icon="el-icon-upload" size="mini" @click="openDialogUpload">上传</el-button>
        </el-row>

        <el-table stripe :data="tableData" tooltip-effect="dark" style="width: 100%">
            <el-table-column type="index" width="50"></el-table-column>

            <el-table-column prop="name" label="名称" width="200" show-overflow-tooltip></el-table-column>
            <el-table-column prop="type" label="类型" width="250" show-overflow-tooltip></el-table-column>

            <el-table-column prop="path" label="URL" min-width="420" show-overflow-tooltip>
                <template slot-scope="scope">
                    <el-button size="mini" icon="el-icon-document" circle @click="handleCopyURL(scope.row.path)"></el-button>
                    <span style="margin-left: 5px;">{{ scope.row.path }}</span>
                </template>
            </el-table-column>

            <el-table-column prop="uploaded" width="200" label="上传时间" show-overflow-tooltip></el-table-column>
            <el-table-column prop="extension" width="100" label="扩展名" show-overflow-tooltip></el-table-column>
            <el-table-column prop="size" width="100" label="大小"></el-table-column>


            <el-table-column label="操作" width="200">
                <template slot-scope="scope">
                    <el-button size="mini" type="info" icon="el-icon-download" circle @click="handleDownload(scope.row)"></el-button>
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
                pageSize: 10,
                currentPage: 1,
                total: 0,
                dialogUploadVisible: false,
                fileList: [],
                tableData: []
            }
        },

        mounted() {
            this.listAttachmentWithPage();
            this.getTotalRecord();
        },

        methods: {
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
                this.$axios.get('/admin/api/attachment/listWithPage', {
                    params: {
                        currentPage: this.currentPage,
                        pageSize: this.pageSize
                    }
                }).then((response) => {
                    this.tableData = response.data;
                }).catch((error) => { console.log(error); });
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

                    // 删除成功 刷新文章列表 刷新总记录数
                    this.listAttachmentWithPage();
                    this.getTotalRecord();
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            }).catch((error) => { console.log(error); });

            });

            },

            submitUpload() {
                this.$refs.upload.submit();
            },

            openDialogUpload :function () {
                this.fileList = [];
                this.dialogUploadVisible = true;
            },

            handleSizeChange: function () {

            },

            handleCurrentChange: function () {

            }
        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>
</body>
</html>