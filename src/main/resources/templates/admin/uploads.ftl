<#--<form action="${request.contextPath}/admin/api/upload" method="post" enctype="multipart/form-data">-->
    <#--文件：<input type="file" multiple name="files"><br/>-->
    <#--<input type="submit" value="提交"><br/>-->
<#--</form>-->

<#assign title = "附件管理">
<#assign activeMenu = "3">
<#include "common/header.ftl">

<el-container>
    <el-main>
        <#--dialogUpload-->
        <el-dialog title="上传" :visible.sync="dialogUploadVisible">
            <el-upload ref="upload"
                       action="/admin/api/upload"
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
            <el-button icon="el-icon-refresh" size="mini" @click="openDialogUpload">刷新</el-button>
            <el-button type="primary" icon="el-icon-upload" size="mini" @click="openDialogUpload">上传</el-button>
        </el-row>

        <el-table stripe :data="tableData" style="width: 100%">
            <el-table-column type="index" width="50"></el-table-column>

            <el-table-column prop="name" label="名称" width="180"></el-table-column>
            <el-table-column prop="type" label="类型" width="180"></el-table-column>
            <el-table-column prop="url" label="URL">
                <template slot-scope="scope">
                    <el-button size="mini" icon="el-icon-document" circle @click="handleCopyUrl(scope.row)"></el-button>
                    <span style="margin-left: 10px;">{{ scope.row.url }}</span>
                </template>
            </el-table-column>

            <el-table-column label="操作">
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
                tableData: [{
                    name: '11',
                    type: 'image/jpeg',
                    url: 'http://localhost:8080/uploads/11.jpg'
                }, {
                    name: '22',
                    type: 'image/jpeg',
                    url: 'http://localhost:8080/uploads/12.jpg'
                }, {
                    name: '33',
                    type: 'image/jpeg',
                    url: 'http://localhost:8080/uploads/13.jpg'
                }, {
                    name: '44',
                    type: 'image/jpeg',
                    url: 'http://localhost:8080/uploads/14.jpg'
                }]
            }
        },

        mounted() {},

        methods: {
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