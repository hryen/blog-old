<el-footer>
    <p style="float: left; font-size: 0.9em; color: #888;">&copy; ${.now?string("yyyy")} by Henry.</p>
    <p style="float: right; font-size: 0.9em; color: #888;">Version 0.1</p>
</el-footer>

<#--设置left-menu的高度为100%-80(header)px 当窗口尺寸变化时 自动改变高度-->
<script>
    var leftMenuUl = document.getElementById('left-menu').children[0];
    leftMenuUl.style.borderRight = 'unset';

    var leftMenu = document.getElementById('left-menu');
    leftMenu.style.borderRight = 'solid 1px #e6e6e6';

    function setLeftMenuHeight() {
        var leftMenu = document.getElementById('left-menu');
        var clientHeight = document.documentElement.clientHeight;
        leftMenu.style.height = (clientHeight - 80)+'px';
    }

    setLeftMenuHeight();

    window.onresize = function () { setLeftMenuHeight(); }
</script>
