<#assign title = "新建文章 - 文章管理">
<#assign activeMenu = "2-1">
<#assign isEdit = true>
<#include "common/header.ftl">

			<el-container>
                <el-main>
<#-- breadcrumb -->
                    <el-breadcrumb separator="/" style="margin-bottom: 20px;">
                        <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
                        <el-breadcrumb-item>文章管理</el-breadcrumb-item>
                        <el-breadcrumb-item>新建文章</el-breadcrumb-item>
                    </el-breadcrumb>
<#--new article-->
                    <#--title-->
                    <el-input v-model="article.title" placeholder="请输入标题" autofocus
                              style="width: calc(50% - 13px);margin: 0 10px 10px 0"></el-input>

                    <#--permalink-->
                    <el-input v-model="article.permalink" placeholder="请输入固定链接，留空则使用文章ID"
                              style="width: calc(50% - 13px);margin: 0 0 10px 10px"></el-input>

                    <#--content-->

                        <#--quill editor-->
                        <div id="quillEditor" style="height: 55%;margin-bottom: 10px;"></div>

                    <#--category-->
                    <el-select v-model="article.categoryName" placeholder="请选择分类"
                               style="width: calc(50% - 13px);margin: 0 10px 10px 0">
                        <el-option v-for="categoryName in categoryNameList" :value="categoryName"></el-option>
                    </el-select>

                    <#--tags-->
                    <el-select v-model="article.tagNameList" placeholder="请选择标签或直接输入"
                               multiple filterable allow-create default-first-option clearable
                               style="width: calc(50% - 13px);margin: 0 0 10px 10px">
                        <el-option v-for="tagName in tagNameList" :value="tagName"></el-option>
                    </el-select>

                    <el-form>
                        <#--comment-->
                        <el-form-item label="允许评论" style="margin-bottom: 0;">
                            <el-switch v-model="article.commentStatus"></el-switch>
                        </el-form-item>

                        <#--status-->
                        <el-form-item label="文章状态">
                            <el-radio-group v-model="article.status">
                                <el-radio label="0">已发布</el-radio>
                                <el-radio label="1">已隐藏</el-radio>
                                <el-radio label="2">已置顶</el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-form>

                    <#--publish-->
                    <el-button type="primary" @click="publish()">发布</el-button>
                </el-main>
				
<#-- footer -->
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
                categoryNameList: [],
                tagNameList: [],
			    article: {title: '', permalink: '', htmlContent: '', categoryName: '', tagNameList: [], commentStatus: true, status: '0'},
                quillEditor : ''
            }
		},
		
		mounted() {
            this.getCategoryNameList();
            this.getTagNameList();
            this.initQuillEditor();
        },
		
		methods: {
            getCategoryNameList: function () {
                // 获取全部分类
                this.$axios.get('/admin/api/category/listAllCategory')
                    .then((response) => {
                    // 后台传过来的category是分类对象的数组 但页面的选择器需要的是分类名称的数组
                    for (var i = 0; i < response.data.length; i++) {
                    this.categoryNameList.push(response.data[i].name);
                }
            });
            },

            getTagNameList: function () {
                // 获取全部标签
                this.$axios.get('/admin/api/tag/listAllTag')
                    .then((response) => {
                    // 后台传过来的category是分类对象的数组 但页面的选择器需要的是分类名称的数组
                    for (var i = 0; i < response.data.length; i++) {
                    this.tagNameList.push(response.data[i].name);
                }
            });
            },

            publish: function () {
                // 如果没有填写标题
                if (this.article.title.trim() === "") {
                    this.$message({
                        type: 'warning',
                        message: '请输入文章标题'
                    });
                    return;
                }

                //如果没有选择分类
                if (this.article.categoryName === "") {
                    this.$message({
                        type: 'warning',
                        message: '请选择文章分类'
                    });
                    return;
                }

                // htmlContent
                this.article.htmlContent = this.quillEditor.container.firstChild.innerHTML;

                // 后台的article对象里包含的tagList是tag对象的list 这里将tagNameList转成tag对象的list
                var tagList = [];
                for (var i = 0; i < this.article.tagNameList.length; i++) {
                    var tag = new Object();
                    tag.name = this.article.tagNameList[i];
                    tagList.push(tag);
                }

                this.$axios.post('/admin/api/article/newArticle', {
                    title: this.article.title,
                    permalink: this.article.permalink,
                    htmlContent: this.article.htmlContent,
                    categoryName: this.article.categoryName,
                    tagList: tagList,
                    commentStatus: this.article.commentStatus,
                    status: this.article.status
                }).then((response) => {
                    if (response.data.result) {
                    this.$message({
                        type: 'success',
                        message: response.data.message
                    });

                    // 发布成功 返回文章列表
                    window.location.href="/admin/article/list";
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }
            })
            .catch((error) => {
                console.log(error);
            });





            },

            initQuillEditor: function () {
                var toolbarOptions = [
                    ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
                    ['blockquote', 'code-block'],

                    [{ 'header': 1 }, { 'header': 2 }],            // custom button values
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
                    [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
                    [{ 'direction': 'rtl' }],                         // text direction

                    [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

                    [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                    [{ 'font': [] }],
                    [{ 'align': [] }],
                    ['link', 'image'],                                // link and image

                    ['clean']                                         // remove formatting button
                ];
                this.quillEditor = new Quill('#quillEditor', {
                    theme: 'snow',
                    modules: {
                        toolbar: toolbarOptions
                    }
                });
            }
        }
    }
	
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>

</body>
</html>