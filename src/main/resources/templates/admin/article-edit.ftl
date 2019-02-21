<#assign title = "编辑 - 文章管理">
<#assign isEdit = true>
<#include "common/header.ftl">

<el-container>
    <el-main>
        <#-- breadcrumb -->
        <el-breadcrumb separator="/" style="margin-bottom: 20px;">
            <el-breadcrumb-item><a href="${request.contextPath}/admin">首页</a></el-breadcrumb-item>
            <el-breadcrumb-item>文章管理</el-breadcrumb-item>
            <el-breadcrumb-item>编辑</el-breadcrumb-item>
        </el-breadcrumb>
        <#--new article-->
        <#--title-->
        <el-input v-model="article.title" placeholder="请输入标题"
                  style="width: calc(50% - 13px);margin: 0 10px 10px 0"></el-input>

        <#--permalink-->
        <el-input v-model="article.permalink" placeholder="请输入固定链接，留空则使用文章ID"
                  style="width: calc(50% - 13px);margin: 0 0 10px 10px"></el-input>

        <#--content-->
        <#--markdown editor-->
        <div id="markdownEditor" style="margin-bottom: 10px;">
            <textarea id="markdownEditorTextarea"></textarea>
        </div>

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
            <el-form-item label="文章状态" style="margin-bottom: 10px;">
                <el-radio-group v-model="article.status">
                    <el-radio label="0">已发布</el-radio>
                    <el-radio label="1">已隐藏</el-radio>
                    <el-radio label="2">已置顶</el-radio>
                </el-radio-group>
            </el-form-item>
        </el-form>

        <#--publish-->
        <el-button type="primary" @click="saveArticle()">保存</el-button>

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
                easyMDE: '',
                categoryNameList: [],
                tagNameList: [],
                article: {title: '', permalink: '', markdownContent: '', htmlContent: '', summary: '',
                    categoryName: '', tagNameList: [], commentStatus: true, status: '0'}
            }
        },

        mounted() {
            this.initMarked();
            this.initMarkdownEditor();
            this.getArticleByArticleId();
            this.getCategoryNameList();
            this.getTagNameList();
        },

        methods: {
            getArticleByArticleId: function() {
                // 获取文章
                this.$axios.get('/admin/api/article/getArticleByArticleId/${articleId}')
                    .then((response) => {

                        // 如果文章不存在
                        if (response.data == '') {
                            this.$alert('文章不存在，点击确定返回文章列表', '提示', {
                                type: 'warning',
                                confirmButtonText: '确定',
                                callback: action => {
                                    window.location.href="/admin/article/list";
                                }
                            });
                            return;
                        }

                        this.article = response.data;

                        this.easyMDE.value(this.article.markdownContent);

                        // 后台传过来的article.tagList是标签对象的数组 但页面的选择器需要的是标签名称的数组
                        var tagNameList = [];
                        for (var i = 0; i < response.data.tagList.length; i++) {
                            tagNameList.push(response.data.tagList[i].name);
                        }
                        this.article.tagNameList = tagNameList;
                    });
            },

            initMarked: function() {
                marked.setOptions({
                    baseUrl: 'https://blog.hryen.com',
                    breaks: false,
                    gfm: true,
                    headerIds: true,
                    highlight: function(code) {
                        return hljs.highlightAuto(code).value;
                    },
                    langPrefix: 'lang-',
                    renderer: new marked.Renderer(),
                    sanitize: false,
                    smartLists: true,
                    tables: true
                });
            },

            initMarkdownEditor: function () {
                var toolbarIcons = [
                    "bold","italic","strikethrough","|",
                    "heading","heading-smaller","heading-bigger","|",
                    "heading-1","heading-2","heading-3","|",
                    "code","quote","unordered-list","ordered-list","|",
                    "link","image","table","horizontal-rule","|",
                    "preview","side-by-side","fullscreen","guide"
                ];
                this.easyMDE = new EasyMDE({
                    toolbar: toolbarIcons,
                    element: document.getElementById('markdownEditorTextarea'),
                    indentWithTabs: false,
                    tabSize: 4,
                    status: ["autosave", "lines"],
                    previewRender: function(plainText) {
                        return marked(plainText); // Returns HTML from a custom parser
                    }
                });
            },

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

            saveArticle: function () {
                // 如果没有填写标题
                if (this.article.title.trim() === "") {
                    this.$message({
                        type: 'warning',
                        message: '请输入文章标题'
                    });
                    return;
                }

                // markdownContent
                this.article.markdownContent = this.easyMDE.value();

                // htmlContent
                this.article.htmlContent = marked(this.article.markdownContent);

                // TODO summary 要修改成让用户输入摘要
                this.article.summary = this.article.htmlContent;

                // 后台的article对象里包含的tagList是tag对象的list 这里将tagNameList转成tag对象的list
                var tagList = [];
                for (var i = 0; i < this.article.tagNameList.length; i++) {
                    var tag = new Object();
                    tag.name = this.article.tagNameList[i];
                    tagList.push(tag);
                }

                // TODO 编辑文章 保存方法 要修改 后台还没写api
                this.$axios.post('/admin/api/article/saveArticle', {
                    title: this.article.title,
                    permalink: this.article.permalink,
                    htmlContent: this.article.htmlContent,
                    summary: this.article.summary,
                    categoryName: this.article.categoryName,
                    tagList: tagList,
                    commentStatus: this.article.commentStatus,
                    status: this.article.status
                }).then((response) => {

                    // 发布成功 返回文章列表 弹出对话框询问是查看文章还是返回文章列表
                    if (response.data.result) {
                    // 提示发布成功点击确定返回文章列表
                    this.$alert('发布成功，点击确定返回文章列表', '提示', {
                        type: 'success',
                        confirmButtonText: '确定',
                        callback: action => {
                        window.location.href="/admin/article/list";
                }
                });
                } else {
                    this.$message({
                        type: 'error',
                        message: response.data.message
                    });
                }

            }).catch((error) => { console.log(error); });
            }

        }
    }

    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>

</body>
</html>