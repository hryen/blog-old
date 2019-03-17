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
                                <el-button size="mini"
                                           icon="el-icon-view"
                                           @click="handleView(scope.row)">
                                </el-button>
                                <el-button size="mini"
                                           type="danger"
                                           icon="el-icon-delete"
                                           @click="handleDelete(scope.row)">
                                </el-button>
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
                tableData: [],
                pageSize: 10,
                currentPage: 1,
                total: 0
            }
        },

        mounted() {
            this.loadTableData();
        },

        methods: {
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