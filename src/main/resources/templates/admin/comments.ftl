<#assign title = "评论管理">
<#assign activeMenu = "3">
<#include "common/header.ftl">

            <el-container>
                <el-main>
                    <el-table size="medium" stripe :data="tableData"
                              :default-sort="{prop: 'publishDate', order: 'descending'}"
                              max-height="666" tooltip-effect="dark">

                        <el-table-column type="index" :index="1" width="50" align="center"></el-table-column>

                        <el-table-column label="作者" prop="author" width="200"></el-table-column>

                        <el-table-column label="内容" prop="content" show-overflow-tooltip></el-table-column>

                        <el-table-column label="邮箱" prop="email" show-overflow-tooltip></el-table-column>

                        <el-table-column label="网站" prop="url" show-overflow-tooltip></el-table-column>

                        <el-table-column label="发布日期" prop="publishDate" width="200" show-overflow-tooltip sortable>
                            <template slot-scope="scope">
                                <!-- 截取日期 只显示到分 -->
                                <span>{{ scope.row.publishDate.substring(0,16) }}</span>
                            </template>
                        </el-table-column>

                        <el-table-column label="操作">
                            <template slot-scope="scope">
                                <el-button size="mini" @click="handleView(scope.row)">查看</el-button>
                                <el-button size="mini" type="info" @click="handleReply(scope.row)">回复</el-button>
                                <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
                            </template>
                        </el-table-column>

                    </el-table>

                    <el-pagination prev-text="上一页" next-text="下一页" style="margin-top: 10px;"
                                   @size-change="handleSizeChange" @current-change="handleCurrentChange"
                                   layout="total, sizes, prev, pager, next, jumper"
                                   :total.sync="total" :page-size.sync="pageSize" :current-page.sync="currentPage">
                    </el-pagination>

                    <el-dialog title="回复" :visible.sync="replyDialogVisible" width="30%" :before-close="handleClose">
                        <el-input type="textarea" :rows="4" placeholder="请输入内容" v-model="content"></el-input>
                        <span slot="footer" class="dialog-footer">
                            <el-button @click="dialogVisible = false">取 消</el-button>
                            <el-button type="primary" @click="submitReply">确 定</el-button>
                        </span>
                    </el-dialog>
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
                pageSize: 10,
                currentPage: 1,
                total: 0,
                replyDialogVisible: false,
                articleId: '',
                parentId: '',
                content: ''
            }
        },

        mounted() {
            this.loadTableData();
        },

        methods: {

            submitReply: function() {
                this.replyDialogVisible = false;
                this.$axios.post('/api/comment/save', {
                    articleId: this.articleId,
                    parentId: this.parentId,
                    content: this.content,
                    author: '${Session["user"].username}',
                    email: '${Session["user"].email}'
                }).then((response) => {
                    if (response.data.result) {
                    this.$message({type: 'success', message: response.data.message});
                    // 回复成功 刷新列表
                    this.loadTableData();
                    this.content = '';
                } else {
                    this.$message({type: 'error', message: response.data.message});
                }
            }).catch((error) => {
                    console.log(error);
            });
            },

            handleReply :function(row) {
                this.replyDialogVisible = true;
                this.articleId = row.articleId;
                this.parentId = row.id;
            },

            handleClose: function(done) { this.$confirm('确认关闭？').then(_ => { done(); }).catch(_ => {}); },

            loadTableData: function() {
                this.getAllCommentTotalRecord();
                this.listCommentsWithPage();
            },

            handleSizeChange: function() { this.loadTableData(); },

            handleCurrentChange: function() { this.loadTableData(); },

            getAllCommentTotalRecord: function () {
                this.$axios.get('/admin/api/comment/getAllCommentTotalRecord').then((response) => {
                    this.total = response.data;
                });
            },

            listCommentsWithPage: function () {
                this.$axios.get('/admin/api/comment/listCommentsWithPage', {
                    params: {
                        currentPage: this.currentPage,
                        pageSize: this.pageSize
                    }
                }).then((response) => {
                    this.tableData = response.data;
                }).catch((error) => {
                    console.log(error);
                });
            },

            handleView: function (row) {
                window.open('/article/' + row.articleId + '#comment-' + row.id);
            },

            handleDelete: function (row) {
                this.$confirm('确定要删除此评论和此评论的所有回复吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    // 执行删除 返回true或false
                    this.$axios.post('/admin/api/comment/delete', {
                        id: row.id,
                        articleId: row.articleId
                    }).then((response) => {
                        if (response.data.result) {
                            this.$message({type: 'success', message: response.data.message});
                            // 删除成功 刷新列表
                            this.loadTableData();
                        } else {
                            this.$message({type: 'error', message: response.data.message});
                        }
                    }).catch((error) => {
                        console.log(error);
                    });
                });
            }

        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>

</body>
</html>