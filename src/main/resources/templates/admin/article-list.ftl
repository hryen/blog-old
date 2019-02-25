<#assign title = "所有文章 - 文章管理">
<#assign activeMenu = "2-2">
<#include "common/header.ftl">

			<el-container>
                <el-main>
<#-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;float: left;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin/index">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>文章管理</el-breadcrumb-item>
                        <el-breadcrumb-item>所有文章</el-breadcrumb-item>
                    </el-breadcrumb>
					<el-row style="float: right;">
						<el-button size="mini" icon="el-icon-refresh" plain @click="handleListArticleWithPage()">刷新</el-button>
					</el-row>
<#-- table -->
                    <template>
                        <el-table size="medium" stripe :data="tableData"
						:default-sort="{prop: 'publishDate', order: 'descending'}"
						v-loading="loading" max-height="666" tooltip-effect="dark"
						style="width: 100%;">

							<el-table-column type="expand">
								<template slot-scope="props">
									<el-form label-position="left" inline class="table-expand">
										<el-form-item label="ID">
											<span>{{ props.row.id }}</span>
										</el-form-item>

										<el-form-item label="链接">
											<span v-if="props.row.permalink === null">/article/{{ props.row.id }}</span>
											<span v-else>/article/{{ props.row.permalink }}</span>
										</el-form-item>


										<el-form-item label="标签">
											<el-tag v-for="tag in props.row.tagList"
													size="small" type="info" disable-transitions
													style="margin-right: 5px;">
												{{ tag.name }}
											</el-tag>
										</el-form-item>

										<el-form-item label="评论">
											<span v-if="props.row.commentStatus === true">允许</span>
											<span v-else>禁止</span>
										</el-form-item>
									</el-form>
								</template>
							</el-table-column>

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
							
                            <el-table-column label="标题" prop="title"  show-overflow-tooltip sortable></el-table-column>

							<el-table-column label="分类" prop="categoryName" width="200" show-overflow-tooltip sortable></el-table-column>
							
							<el-table-column label="发布日期" prop="publishDate" width="200" show-overflow-tooltip sortable>
							    <template slot-scope="scope">
									<!-- 截取日期 只显示到分 -->
							        <span>{{ scope.row.publishDate.substring(0,16) }}</span>
							    </template>
							</el-table-column>

							<el-table-column label="最后修改日期" prop="lastModifiedDate" width="200" show-overflow-tooltip sortable>
								<template slot-scope="scope">
									<span>{{ scope.row.lastModifiedDate.substring(0,16) }}</span>
								</template>
							</el-table-column>

                            <el-table-column label="操作" width="240">
                                <template slot-scope="scope">
                                	<el-button size="mini" icon="el-icon-view" @click="handleView(scope.row)"></el-button>
                                	<el-button size="mini" icon="el-icon-setting" @click="handleSetting(scope.row)"></el-button>
                                	<el-button size="mini" type="info" icon="el-icon-edit-outline" @click="handleEdit(scope.row)"></el-button>
                                	<el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.row)"></el-button>
                                </template>
                            </el-table-column>
							
                        </el-table>
                    </template>

<#-- pagination -->
                    <el-pagination prev-text="上一页" next-text="下一页" style="margin-top: 10px;"
					@size-change="handleSizeChange" @current-change="handleCurrentChange"
					layout="total, sizes, prev, pager, next, jumper"
					:total.sync="total" :page-size.sync="pageSize" :current-page.sync="currentPage">
                    </el-pagination>

                </el-main>
				
<#-- footer -->
				<#include "common/footer.ftl">
            </el-container>
        </el-container>
    </el-container>
	
	
	
<#-- dialogArticleSettings -->
	<el-dialog title="设置" :visible.sync="dialogArticleSettingsVisible" width="30%">
		<el-form :model="form" label-width="80px">
			<el-form-item label="标题"><el-input v-model="form.title"></el-input></el-form-item>
			<el-form-item label="固定链接"><el-input v-model="form.permalink"></el-input></el-form-item>
			<el-form-item label="分类">
				<el-select style="width: 100%;" v-model="form.categoryName" placeholder="请选择">
					<el-option v-for="category in categoryList" :value="category.name"></el-option>
				</el-select>
			</el-form-item>
			<el-form-item label="标签">
				<el-select style="width: 100%;" v-model="form.tagNameList" placeholder="请选择或直接输入"
				multiple filterable allow-create default-first-option clearable>
					<el-option v-for="tag in tagList" :value="tag.name"></el-option>
				</el-select>
			</el-form-item>
			<el-form-item label="状态">
				<el-select style="width: 100%;" :value.sync="form.status" @change="handleFormStatusSelectChange">
					<el-option label="已发布" value="0"></el-option>
					<el-option label="已隐藏" value="1"></el-option>
					<el-option label="已置顶" value="2"></el-option>
				</el-select>
			</el-form-item>
			<el-form-item label="允许评论">
				<el-select style="width: 100%;" :value.sync="form.commentStatus" @change="handleFormCommentStatusSelectChange">
					<el-option label="是" value="1"></el-option>
					<el-option label="否" value="0"></el-option>
				</el-select>
			</el-form-item>
		</el-form>
		<span slot="footer" class="dialog-footer">
			<el-button size="small" @click="handleClose">取消</el-button>
			<el-button size="small" type="primary" @click="handleSubmitForm">确定</el-button>
		</span>
	</el-dialog>
	
	
	
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
				total: '',
				dialogArticleSettingsVisible: false,
				form: {id: '', title: '', permalink: '', status: '', categoryName: '', tagNameList: [], commentStatus: true},
				categoryList: [],
				tagList: []
			}
		},
		
		mounted() {
			this.getAllArticleTotalRecord();
			this.handleListArticleWithPage();
		},
		
		methods: {
			getTagList: function () {
				this.$axios.get('/admin/api/tag/listAllTag')
						.then((response) => { this.tagList = response.data; });
			},

			getCategoryList: function () {
				this.$axios.get('/admin/api/category/listAllCategory')
						.then((response) => { this.categoryList = response.data; });
			},

			handleFormStatusSelectChange(val) {
				this.form.status = val;
			},
			handleFormCommentStatusSelectChange(val) {
				this.form.commentStatus = val;
			},
			handleSubmitForm() {
				// 先判断标题是否为空 为空不继续执行之后的代码
				if (this.form.title.trim() === "") {
					this.$message({type: 'warning', message: '标题不可以为空'});
					return;
				}
				
				this.dialogArticleSettingsVisible = false;
				
				if (this.form.commentStatus === "1") { this.form.commentStatus = true; }
				else { this.form.commentStatus = false; }
				
				// 如果用户清空了字段 会传过来"" 要把它设置成null
				if (this.form.permalink == null || this.form.permalink.trim() === "") { this.form.permalink = null; }
				else { this.form.permalink = this.form.permalink.trim(); }
				
				this.updateArticleSettingsByArticleId(this.form);
			},

			handleClose: function() {
				this.dialogArticleSettingsVisible = false;
			},

			handleView: function(row) {
				if (null != row.permalink) {
					window.open("/article/"+row.permalink);
				} else {
					window.open("/article/"+row.id);
				}
            },

			handleSetting: function(row) {

				// 加载分类和标签列表
				this.getCategoryList();
				this.getTagList();

				this.form.id = row.id;
				this.form.title = row.title.trim();
				this.form.permalink = row.permalink;
				this.form.categoryName = row.categoryName;
				
				// 后台传过来的tag是 标签对象 的数组 但页面的选择器需要的是 标签名称 的数组
				this.form.tagNameList = [];
				for (var i = 0; i < row.tagList.length; i++) {
					this.form.tagNameList.push(row.tagList[i].name);
				}
				
				this.form.status = row.status;

				if (row.commentStatus) {
					this.form.commentStatus = "1";
				} else {
					this.form.commentStatus = "0";
				}
				
				this.dialogArticleSettingsVisible = true;
			},
            handleEdit: function(row) { window.location.href = "/admin/article/edit/"+row.id; },

            handleDelete: function(row) { this.doDelete(row.id); },

            handleSizeChange: function() { this.handleListArticleWithPage(); },

            handleCurrentChange: function() { this.handleListArticleWithPage(); },
			
			// 更新文章设置
			updateArticleSettingsByArticleId: function (form) {
				this.$axios.post('/admin/api/article/updateArticleSettingsByArticleId', {
					id: form.id,
					title: form.title,
					permalink: form.permalink,
					status: form.status,
					categoryName: form.categoryName,
					tagNameList: form.tagNameList,
					commentStatus: form.commentStatus
				})
				.then((response) => {
					if (response.data.result) {
						this.$message({
							type: 'success',
							message: response.data.message
						});
						// 更新成功 刷新文章列表
						this.handleListArticleWithPage();
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
			},
			
			// 获取除了回收站的所有文章总数
			getAllArticleTotalRecord: function () {
				this.loading = true;
				this.$axios.get('/admin/api/article/getAllArticleTotalRecord').then((response) => {
					this.total = response.data;
				});
				this.loading = false;
			},
			
			// 获取所有文章 带分页 按日期排序
			handleListArticleWithPage: function () {
				this.loading = true;
                this.$axios.get('/admin/api/article/listArticleWithPage', {
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
			
			// 删除文章方法
            doDelete: function (id) {
				this.$confirm('确定要将此文章移到回收站吗?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.loading = true;
					// 执行删除 返回true或false
					this.$axios.post('/admin/api/article/deleteArticleById', {
						articleId: id,
						realDelete: false // 为true则直接彻底删除 为false是标记为已删除 回收站功能
					})
					.then((response) => {
						if (response.data.result) {
							this.$message({
								type: 'success',
								message: response.data.message
							});
							// 删除成功 刷新文章列表
							this.handleListArticleWithPage();
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