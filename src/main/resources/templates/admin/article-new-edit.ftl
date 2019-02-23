<#if isEdit!false>
    <#assign title = "编辑文章 - 文章管理">
<#else>
    <#assign title = "新建文章 - 文章管理">
    <#assign activeMenu = "2-1">
</#if>

<#assign editor = true>
<#include "common/header.ftl">

<#--main-->
<el-container>
    <el-main>
        <#-- breadcrumb -->
        <el-breadcrumb separator="/" style="margin-bottom: 20px;">
            <el-breadcrumb-item><a href="${request.contextPath}/admin/index">首页</a></el-breadcrumb-item>
            <el-breadcrumb-item>文章管理</el-breadcrumb-item>
            <#if isEdit!false>
                <el-breadcrumb-item>编辑文章</el-breadcrumb-item>
            <#else>
                <el-breadcrumb-item>新建文章</el-breadcrumb-item>
            </#if>
        </el-breadcrumb>

        <#--title-->
        <el-input v-model="article.title" placeholder="请输入标题"
                  style="width: calc(50% - 13px);margin: 0 10px 10px 0"></el-input>

        <#--permalink-->
        <el-input v-model="article.permalink" placeholder="请输入固定链接，留空则使用文章ID"
                  style="width: calc(50% - 13px);margin: 0 0 10px 10px"></el-input>

        <#--markdown editor-->
        <div id="markdownEditor" style="margin-bottom: 10px;">
            <textarea id="markdownEditorTextarea"></textarea>
        </div>

        <#--category-->
        <el-select v-model="article.categoryName" placeholder="请选择分类"
                   style="width: calc(50% - 13px);margin: 0 10px 10px 0">
            <el-option v-for="category in categoryList" :value="category.name"></el-option>
        </el-select>

        <#--tags-->
        <el-select v-model="article.tagNameList" placeholder="请选择标签或直接输入"
                   multiple filterable allow-create default-first-option clearable
                   style="width: calc(50% - 13px);margin: 0 0 10px 10px">
            <el-option v-for="tag in tagList" :value="tag.name"></el-option>
        </el-select>

        <el-form>
            <#--comment status-->
            <el-form-item label="评论" style="margin-bottom: 0;">
                <el-switch v-model="article.commentStatus"></el-switch>
            </el-form-item>

            <#--status-->
            <el-form-item label="状态" style="margin-bottom: 10px;">
                <el-radio-group v-model="article.status">
                    <el-radio label="0">已发布</el-radio>
                    <el-radio label="1">已隐藏</el-radio>
                    <el-radio label="2">已置顶</el-radio>
                </el-radio-group>
            </el-form-item>
        </el-form>

        <#if isEdit!false>
            <el-button type="primary" @click="updateArticle()">更新</el-button>
        <#else>
            <el-button type="primary" @click="publishArticle()">发布</el-button>
        </#if>

    </el-main>

    <#-- main footer -->
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
                categoryList: [],
                tagList: [],
                article: {
                    title: '',
                    permalink: '',
                    markdownContent: '',
                    htmlContent: '',
                    summary: '',
                    categoryName: '',
                    tagNameList: [],
                    commentStatus: true,
                    status: '0'
                }
            }
        },

        mounted() {
            this.initMarked();
            this.initEasyMDE();
            this.getCategoryList();
            this.getTagList();
            <#if isEdit!false>
            this.getArticleByArticleId();
            </#if>
        },

        methods: {
            initMarked: function() {
                marked.setOptions({
                    breaks: false,
                    gfm: true,
                    headerIds: true,
                    highlight: function(code) { return hljs.highlightAuto(code).value; },
                    langPrefix: 'lang-',
                    sanitize: false,
                    smartLists: true,
                    tables: true
                });
            },

            initEasyMDE: function () {
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
                            cm.replaceSelection('\n\n<ul class="tasks">\n' +
                                '    <li><input disabled="" type="checkbox">task1 to do</li>\n' +
                                '    <li><input checked="" disabled="" type="checkbox">task2 done</li>\n' +
                                '</ul>\n\n');
                            cm.focus();
                        },
                        className: "fa fa-check-square",
                        title: "Insert Task List",
                    },
                    {
                        name: "readMore",
                        action: function customFunction(editor){
                            var cm = editor.codemirror;
                            cm.replaceSelection('\n\n<!--more-->\n\n');
                            cm.focus();
                        },
                        className: "fa fa-ellipsis-h",
                        title: "Insert ReadMore",
                    },
                    "|", "preview","side-by-side","fullscreen","guide"
                ];
                this.easyMDE = new EasyMDE({
                    toolbar: toolbarIcons,
                    element: document.getElementById('markdownEditorTextarea'),
                    indentWithTabs: false,
                    tabSize: 4,
                    status: ["autosave", "lines"],
                    previewRender: function(plainText) { return marked(plainText); }
                });
            },

            getCategoryList: function () {
                this.$axios.get('/admin/api/category/listAllCategory')
                    .then((response) => {
                        this.categoryList = response.data;
                    });
            },

            getTagList: function () {
                this.$axios.get('/admin/api/tag/listAllTag')
                    .then((response) => {
                        this.tagList = response.data;
                    });
            },

            <#if isEdit!false><#-- 如果是编辑页面 加载 获取文章方法 和 更新文章方法 -->
            getArticleByArticleId: function() {
                this.$axios.get('/admin/api/article/getArticleByArticleId/${articleId}')
                    .then((response) => {
                        // 如果文章不存在
                        if (response.data == '') {
                            this.$alert('文章不存在，点击确定返回文章列表', '提示', {
                                type: 'warning',
                                confirmButtonText: '确定',
                                callback: action => { window.location.href="/admin/article/list"; }
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

                        // 后台传过来的article.tagList是 标签对象 的数组 但页面的选择器需要的是 标签名称 的数组
                        for (var i = 0; i < response.data.tagList.length; i++) {
                            this.article.tagNameList.push(response.data.tagList[i].name);
                        }

                        // 初始化编辑器内容
                        this.easyMDE.value(this.article.markdownContent);
                    });
            },

            updateArticle: function () {
                // 如果没有填写标题
                if (this.article.title.trim() === "") {
                    this.$message({type: 'warning', message: '请输入文章标题'});
                    return;
                }

                // markdownContent
                this.article.markdownContent = this.easyMDE.value();

                // htmlContent
                this.article.htmlContent = marked(this.article.markdownContent);

                // summary
                var readMoreIndex = this.article.htmlContent.indexOf("<!--more-->");
                if (-1 == readMoreIndex) {
                    // 如果内容不包含renadmore标签 文章摘要和内容一样
                    this.article.summary = this.article.htmlContent;
                } else {
                    this.article.summary = this.article.htmlContent.substring(0, readMoreIndex);
                }

                // 发送请求
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
                    if (response.data.result) {
                        // 保存成功 提示点击确定返回文章列表
                        this.$alert('保存成功，点击确定返回文章列表', '提示', {
                            type: 'success',
                            confirmButtonText: '确定',
                            callback: action => { window.location.href="/admin/article/list"; }
                        });
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
            }
            <#else><#-- 如果不是编辑页面 加载 发布文章方法-->
            publishArticle: function () {
                // 如果没有填写标题
                if (this.article.title.trim() === "") {
                    this.$message({type: 'warning', message: '请输入文章标题'});
                    return;
                }

                // 如果没有选择分类
                if (this.article.categoryName === "") {
                    this.article.categoryName = "Uncategorized";
                }

                // permalink
                if (this.article.permalink == null || this.article.permalink.trim() === "") {
                    this.article.permalink = null;
                } else {
                    this.article.permalink = this.article.permalink.trim();
                }

                // markdownContent
                this.article.markdownContent = this.easyMDE.value();

                // htmlContent
                this.article.htmlContent = marked(this.article.markdownContent);

                // summary
                var readMoreIndex = this.article.htmlContent.indexOf("<!--more-->");
                if (-1 == readMoreIndex) {
                    // 如果内容不包含renadmore标签 文章摘要和内容一样
                    this.article.summary = this.article.htmlContent;
                } else {
                    this.article.summary = this.article.htmlContent.substring(0, readMoreIndex);
                }

                // 后台需要的article对象里包含的tagList是 tag对象 的list 这里将tagNameList转成tag对象的list
                var tagList = [];
                for (var i = 0; i < this.article.tagNameList.length; i++) {
                    var tag = new Object();
                    tag.name = this.article.tagNameList[i];
                    tagList.push(tag);
                }

                // 发送请求
                this.$axios.post('/admin/api/article/newArticle', {
                    title: this.article.title,
                    permalink: this.article.permalink,
                    markdownContent: this.article.markdownContent,
                    htmlContent: this.article.htmlContent,
                    summary: this.article.summary,
                    categoryName: this.article.categoryName,
                    tagList: tagList,
                    commentStatus: this.article.commentStatus,
                    status: this.article.status
                }).then((response) => {
                    if (response.data.result) {
                        // 发布成功 提示点击确定返回文章列表
                        this.$alert('发布成功，点击确定返回文章列表', '提示', {
                            type: 'success',
                            confirmButtonText: '确定',
                            callback: action => { window.location.href="/admin/article/list"; }
                        });
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
            }
            </#if>

        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>
</body>
</html>