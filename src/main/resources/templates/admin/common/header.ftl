<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${request.contextPath}/css/element-ui.min.css">
    <script src="${request.contextPath}/js/vue.min.js"></script>
    <script src="${request.contextPath}/js/element-ui.min.js"></script>
    <script src="${request.contextPath}/js/axios.min.js"></script>
    <#if editor?? && editor == true>
        <#--easymde-->
        <link rel="stylesheet" href="${request.contextPath}/css/easymde.min.css">
        <link rel="stylesheet" href="${request.contextPath}/css/github-markdown.css">
        <script src="${request.contextPath}/js/easymde.min.js"></script>
        <#--marked-->
        <script src="${request.contextPath}/js/marked.min.js"></script>
        <#--highlight-->
        <link rel="stylesheet" href="${request.contextPath}/css/tomorrow.css">
        <script src="${request.contextPath}/js/highlight.min.js"></script>
    </#if>
    <title>${title}</title>
    <style>
        .table-expand { font-size: 0; }
        .table-expand label {
            width: 50px;
            color: #99a9bf;
        }
        .table-expand .el-form-item {
            margin-right: 0;
            margin-bottom: 0;
            width: 50%;
        }
    </style>
</head>
<body style="margin: 0;">
<div id="app">
    <el-container>
        <#-- header -->
        <el-header style="background-color: #6699CC;height: 60px;padding: 10px 20px;">
            <el-row style="text-align: right">
                <el-popover placement="bottom" width="200" trigger="hover">

                    <div style="width: 100%; text-align: center;margin-bottom: 20px;">
                        <img width="100px" height="100px" style="border-radius: 50%;"
                             src="${Session["user"].avatar}">
                        <p style="margin-top: 0;">${Session["user"].username}</p>
                    </div>

                    <div style="float: left;">
                        <el-button size="mini"
                                   @click="window.open('/')">首页</el-button>
                    </div>

                    <div style="float: right;">
                        <el-button size="mini" type="danger"
                                   @click="window.location.href='/admin/logout'">退出</el-button>
                    </div>

                    <img slot="reference" width="40px" height="40px" style="border-radius: 50%;"
                         src="${Session["user"].avatar}">
                </el-popover>

            </el-row>
        </el-header>

        <el-container>
            <#-- menu -->
            <el-aside id="left-menu" width="240px">
                <el-menu default-active=${activeMenu!0}>

                    <a style="text-decoration: none;" href="${request.contextPath}/admin/index">
                        <el-menu-item index="1"><i class="el-icon-info"></i><span slot="title">仪表盘</span>
                        </el-menu-item>
                    </a>

                    <el-submenu index="2">
                        <span slot="title"><i class="el-icon-document"></i>文章管理</span>

                        <a style="text-decoration: none;" href="${request.contextPath}/admin/article/new">
                            <el-menu-item index="2-1"><i class="el-icon-edit"></i><span>新建文章</span></el-menu-item>
                        </a>

                        <a style="text-decoration: none;" href="${request.contextPath}/admin/article/list">
                            <el-menu-item index="2-2"><i class="el-icon-document"></i><span>所有文章</span>
                            </el-menu-item>
                        </a>

                        <a style="text-decoration: none;" href="${request.contextPath}/admin/article/trash">
                            <el-menu-item index="2-3"><i class="el-icon-delete"></i><span>已删除文章</span>
                            </el-menu-item>
                        </a>
                    </el-submenu>

                    <a style="text-decoration: none;" href="${request.contextPath}/admin/uploads">
                        <el-menu-item index="3"><i class="el-icon-menu"></i><span slot="title">附件管理</span>
                        </el-menu-item>
                    </a>

                    <a style="text-decoration: none;" href="${request.contextPath}/admin/categories">
                        <el-menu-item index="4"><i class="el-icon-menu"></i><span slot="title">分类管理</span>
                        </el-menu-item>
                    </a>

                    <a style="text-decoration: none;" href="${request.contextPath}/admin/tags">
                        <el-menu-item index="5"><i class="el-icon-menu"></i><span slot="title">标签管理</span>
                        </el-menu-item>
                    </a>

                    <a style="text-decoration: none;" href="${request.contextPath}/admin/settings">
                        <el-menu-item index="6"><i class="el-icon-setting"></i><span slot="title">博客设置</span>
                        </el-menu-item>
                    </a>

                </el-menu>
            </el-aside>
