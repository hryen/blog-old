<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${request.contextPath}/css/element-ui.min.css">
    <script src="${request.contextPath}/js/vue.min.js"></script>
    <script src="${request.contextPath}/js/element-ui.min.js"></script>
    <script src="${request.contextPath}/js/axios.min.js"></script>
    <title>Login - ${blogTitle}</title>
    <style>
        input, label { margin-bottom: 20px; }
    </style>
</head>
<body style="margin: 0;">
<div id="app">
    <el-container>
        <el-main id="main" style="display: flex;">
            <div style="width: 360px;margin: auto;">
                <el-card id="card" style="padding: 30px 0 20px 0;">
                    <#--form title-->
                    <div slot="header"><span>Log in to ${blogTitle}</span></div>

                    <#--username-->
                    <el-input v-model="username" type="text" placeholder="Username" autofocus></el-input>

                    <#--password-->
                    <el-input v-model="password" type="password" placeholder="Passowrd"></el-input>

                    <#--remember me-->
                    <el-checkbox v-model="remember">Remember me</el-checkbox>

                    <#--submit-->
                    <el-button type="primary" @click="doLogin" style="width: 100%;">Log in</el-button>
                </el-card>
            </div>
        </el-main>
    </el-container>
</div>

<script>
    Vue.prototype.$axios = axios.create({ baseURL: '${request.contextPath}' });

    var Main = {
        data() {
            return {
                username: '',
                password: '',
                remember: true
            }
        },

        methods: {
            doLogin: function () {
                this.$axios.post('/admin/login', {
                    username: this.username,
                    password: this.password,
                    remember: this.remember
                }).then((response) => {
                    if (response.data.result) {
                        window.location.href = "/admin/index";
                    } else {
                        this.$message({type: 'error', message: response.data.message});
                    }
                }).catch((error) => { console.log(error); });
            }
        }
    };

    var Ctor = Vue.extend(Main);
    new Ctor().$mount('#app');
</script>

<#--set main height and card margin-->
<script>
    function setMainHeight(clientHeight) {
        var main = document.getElementById('main');
        main.style.height = clientHeight+'px';
    }

    function setCardMarginTop(clientHeight) {
        var card = document.getElementById('card');
        if (clientHeight < 700) {
            card.style.marginTop = '0';
        } else {
            card.style.marginTop = '-208px';
        }
    }

    var clientHeight = document.documentElement.clientHeight;
    setMainHeight(clientHeight);
    setCardMarginTop(clientHeight);

    window.onresize = function () {
        var clientHeight = document.documentElement.clientHeight;
        setMainHeight(clientHeight);
        setCardMarginTop(clientHeight);
    }
</script>

</body>
</html>
