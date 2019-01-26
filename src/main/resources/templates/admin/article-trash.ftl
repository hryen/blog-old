<#assign title = "已删除文章 - 文章管理">
<#assign active = "2-3">
<#include "common/header.ftl">

			<el-container>
                <el-main>
<!-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;float: left;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>文章管理</el-breadcrumb-item>
                        <el-breadcrumb-item>已删除文章</el-breadcrumb-item>
                    </el-breadcrumb>
					<el-row style="float: right;">
						<el-button size="mini" icon="el-icon-refresh" plain @click="getTrashArticleWithPage()">刷新</el-button>
					</el-row>
<!-- table -->
                    <template>
                        <el-table border size="medium" stripe :data="tableData"
						:default-sort="{prop: 'publishDate', order: 'descending'}"
						v-loading="loading" max-height="666" tooltip-effect="dark"
						style="width: 100%;">
						
							<el-table-column type="index" :index="1" width="50" align="center"></el-table-column>
							
							<el-table-column label="状态" prop="status" sortable width="76" align="center">
							    <template slot-scope="scope">
									<span v-if="scope.row.status === '0'">
										<el-tag disable-transitions size="small">已发布</el-tag>
									</span>
									<span v-else-if="scope.row.status === '1'">
										<el-tag disable-transitions type="info" size="small">已隐藏</el-tag>
									</span>
									<span v-else-if="scope.row.status === '2'">
										<el-tag disable-transitions type="success" size="small">已置顶</el-tag>
										</span>
									<span v-else-if="scope.row.status === '3'">
										<el-tag disable-transitions type="warning" size="small">已删除</el-tag>
										</span>
									<span v-else>{{ scope.row.status }}</span>
							    </template>
							</el-table-column>
							
                            <el-table-column label="标题" prop="title" show-overflow-tooltip sortable></el-table-column>
							
							<el-table-column label="所属分类" prop="categoryName" show-overflow-tooltip></el-table-column>
							
							<el-table-column label="固定链接" prop="permalink" show-overflow-tooltip>
								<template slot-scope="scope">
									<span v-if="scope.row.permalink === null">/article/{{ scope.row.id }}</span>
									<span v-else>/article/{{ scope.row.permalink }}</span>
								</template>
							</el-table-column>
							
							<el-table-column label="允许评论" prop="commentStatus" width="110" sortable align="center">
								<template slot-scope="scope">
									<span v-if="scope.row.commentStatus === true">是</span>
									<span v-else>否</span>
								</template>
							</el-table-column>
							
							<el-table-column label="发布日期" prop="publishDate" width="150" show-overflow-tooltip sortable>
							    <template slot-scope="scope">
									<!-- 截取日期 只显示到分 -->
							        <span>{{ scope.row.publishDate.substring(0,16) }}</span>
							    </template>
							</el-table-column>
							
                            <el-table-column label="最后修改日期" prop="lastModifiedDate" width="150" show-overflow-tooltip sortable>
                                <template slot-scope="scope">
                                    <span>{{ scope.row.lastModifiedDate.substring(0,16) }}</span>
                                </template>
                            </el-table-column>
							
							<el-table-column label="类型" prop="type" width="104" show-overflow-tooltip sortable></el-table-column>
							
							<el-table-column label="ID" prop="id" width="98" show-overflow-tooltip sortable></el-table-column>

                            <el-table-column label="操作" width="172">
                                <template slot-scope="scope">
                                	<el-button size="mini" type="info" @click="handleRestore(scope.row)">恢复</el-button>
                                	<el-button size="mini" type="danger" @click="handleDelete(scope.row)">永久删除</el-button>
                                </template>
                            </el-table-column>
							
                        </el-table>
                    </template>

<!-- pagination -->
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
				loading: true,
				pageSize: 10,
				currentPage: 1,
				total: ''
			}
		},
		
		mounted() {
			this.getTrashArticleTotalRecord();
			this.getTrashArticleWithPage();
		},
		
		methods: {
			handleRestore(row) {
                this.doRestore(row.id);
            },
            handleDelete(row) {
                this.doDelete(row.id);
            },
            handleSizeChange() {
				this.getTrashArticleWithPage();
            },
            handleCurrentChange() {
                this.getTrashArticleWithPage();
            },

			// 获取回收站的所有文章总数
			getTrashArticleTotalRecord: function () {
				this.loading = true;
				this.$axios.get('/admin/api/article/getTrashArticleTotalRecord').then((response) => {
					this.total = response.data;
			});
				this.loading = false;
			},

			// 获取回收站的所有文章 带分页 按日期排序
			getTrashArticleWithPage: function () {
				this.loading = true;
				this.$axios.get('/admin/api/article/getTrashArticleWithPage', {
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


			// 恢复文章方法
			doRestore: function (id) {
				this.$confirm('文章将被恢复成隐藏状态，确定要恢复此文章吗?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.loading = true;
				// 执行恢复
				this.$axios.post('/admin/api/article/restoreArticleById', { articleId: id })
					.then((response) => {
						if (response.data) {
							this.$message({
								type: 'success',
								message: response.data.message
					});
					// 恢复成功 刷新文章列表
					this.getTrashArticleWithPage();
					// 总数减一 就不去服务器在查了
					this.total--;
				} else {
					this.$message({
						type: 'error',
						message: response.data.message
					});
				}
				this.loading = false;
			})
			.catch((error) => {
					this.loading = false;
				console.log(error);
			});
			}).catch(() => {
					this.loading = false;
				this.$message({
					type: 'info',
					message: '操作已取消。'
				});
			});
			},

			// 删除文章方法
            doDelete: function (id) {
				this.$confirm('此操作将不可逆，确定要永久删除此文章吗?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.loading = true;
					// 执行删除 返回true或false
					this.$axios.post('/admin/api/article/deleteArticleById', {
						articleId: id,
						realDelete: true // 为true则直接彻底删除
					})
					.then((response) => {
						if (response.data.result) {
							this.$message({
								type: 'success',
								message: response.data.message
							});
							// 删除成功 刷新文章列表
							this.getTrashArticleWithPage();
							// 总数减一 就不去服务器在查了
							this.total--;
						} else {
							this.$message({
								type: 'error',
								message: response.data.message
							});
						}
						this.loading = false;
					})
					.catch((error) => {
						this.loading = false;
						console.log(error);
					});
				}).catch(() => {
					this.loading = false;
					this.$message({
						type: 'info',
						message: '操作已取消。'
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