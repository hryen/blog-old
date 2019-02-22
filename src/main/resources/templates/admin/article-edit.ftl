<#assign title = "编辑 - 文章管理">
<#assign editor = true>
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
            <#--comment status-->
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
                    categoryName: '', tagNameList: [], commentStatus: '', status: ''}
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

                        this.article.id = response.data.id;
                        this.article.title = response.data.title;
                        this.article.permalink = response.data.permalink;
                        this.article.markdownContent = response.data.markdownContent;
                        this.article.categoryName = response.data.categoryName;
                        this.article.commentStatus = response.data.commentStatus;
                        this.article.status = response.data.status;

                        // 后台传过来的article.tagList是标签对象的数组 但页面的选择器需要的是标签名称的数组
                        for (var i = 0; i < response.data.tagList.length; i++) {
                            this.article.tagNameList.push(response.data.tagList[i].name);
                        }

                        // 初始化编辑器内容
                        this.easyMDE.value(this.article.markdownContent);

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
                    "bold","italic","strikethrough","heading","|",
                    "code","quote","unordered-list","ordered-list","|",
                    "link","image","table","horizontal-rule","|",
                    {
                        name: "superscript",
                        action: function customFunction(editor){
                            var cm = editor.codemirror;
                            cm.replaceSelection('<sup></sup>');
                            cm.focus();
                        },
                        className: "fa fa-superscript",
                        title: "Insert Superscript",
                    },
                    {
                        name: "subscript",
                        action: function customFunction(editor){
                            var cm = editor.codemirror;
                            cm.replaceSelection('<sub></sub>');
                            cm.focus()
                        },
                        className: "fa fa-subscript",
                        title: "Insert Subscript",
                    },
                    {
                        name: "tasks",
                        action: function customFunction(editor){
                            var cm = editor.codemirror;
                            cm.replaceSelection('\n<ul class="tasks">\n' +
                                '    <li><input disabled="" type="checkbox">task1 to do</li>\n' +
                                '    <li><input checked="" disabled="" type="checkbox">task2 done</li>\n' +
                                '</ul>\n\n');
                            cm.focus();
                        },
                        className: "fa fa-check-square",
                        title: "Insert Tasks",
                    },
                    {
                        name: "readMore",
                        action: function customFunction(editor){
                            var cm = editor.codemirror;
                            cm.replaceSelection('\n<!--more-->\n\n');
                            cm.focus();
                        },
                        className: "fa fa-ellipsis-h",
                        title: "Insert ReadMore",
                    },"|",
                    "preview","side-by-side","fullscreen","guide"
                ];
                this.easyMDE = new EasyMDE({
                    toolbar: toolbarIcons,
                    element: document.getElementById('markdownEditorTextarea'),
                    indentWithTabs: false,
                    tabSize: 4,
                    status: ["autosave", "lines"],
                    previewRender: function(plainText) {
                        return marked(plainText); // Returns HTML from marked
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
                    // 后台传过来的是标签对象的数组 但页面的选择器需要的是标签名称的数组
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

                // summary
                var moreIndex = this.article.htmlContent.indexOf("<!--more-->");
                this.article.summary = this.article.htmlContent.substring(0, moreIndex);

                // TODO 编辑文章 保存方法 要修改 后台还没写api
                this.$axios.post('/admin/api/article/updateArticleByArticleId', {
                    id: this.article.id,
                    title: this.article.title,
                    permalink: this.article.permalink,
                    htmlContent: this.article.htmlContent,
                    markdownContent: this.article.markdownContent,
                    summary: this.article.summary,
                    categoryName: this.article.categoryName,
                    tagNameList: this.article.tagNameList,
                    commentStatus: this.article.commentStatus,
                    status: this.article.status
                }).then((response) => {

                    // 保存成功 返回文章列表
                    if (response.data.result) {
                    // 提示保存成功点击确定返回文章列表
                    this.$alert('保存成功，点击确定返回文章列表', '提示', {
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