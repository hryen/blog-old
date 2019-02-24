<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${request.contextPath}/css/element-ui.min.css">
    <script src="${request.contextPath}/js/vue.min.js"></script>
    <script src="${request.contextPath}/js/element-ui.min.js"></script>
    <script src="${request.contextPath}/js/axios.min.js"></script>
    <title>Sign in</title>
</head>
<body style="margin: 0;">
<div id="app">
    <el-container>
        <el-main id="main" style="display: flex;">
            <div style="width: 360px;margin: auto;">
                <el-card class="box-card" style="padding: 40px 0 20px 0;">
                    <div slot="header" class="clearfix"><span>Sign in</span></div>

                    <el-input v-model="form.username" type="text" placeholder="Username"
                              autofocus style="margin-bottom: 20px;">
                    </el-input>

                    <el-input v-model="form.password" type="password" placeholder="Passowrd"
                              style="margin-bottom: 20px;">
                    </el-input>

                    <el-checkbox v-model="form.remember" style="margin-bottom: 20px;">Remember me</el-checkbox>

                    <el-button type="primary" @click="formSubmit" style="width: 100%;">Sign in</el-button>
                </el-card>
            </div>

        </el-main>
    </el-container>
</div>

<script>
    function setMainHeight() {
        var main = document.getElementById('main');
        var clientHeight = document.documentElement.clientHeight;
        main.style.height = clientHeight+'px';
    }

    setMainHeight();

    window.onresize = function () { setMainHeight(); }
</script>

<script>
    Vue.prototype.$axios = axios.create({ baseURL: '${request.contextPath}' });

    var Main = {
        data() {
            return {
                form: {
                    username: '',
                    password: '',
                    remember: true
                }
            }
        },

        mounted() {},

        methods: {
            formSubmit: function () {
                this.$axios.post('/admin/login', {
                    username: this.form.username,
                    password: this.form.password,
                    remember: this.form.remember
                }).then((response) => {
                    console.log(response);
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

</body>
</html>
