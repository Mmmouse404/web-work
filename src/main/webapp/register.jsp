<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="css/register.css">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            padding: 0;
        }

        h2 {
            font-size: 24px; /* 增加标题字体大小 */
            color: #fff; /* 白色字体 */
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* 字体阴影 */
        }

        input {
            width: 278px;
            height: 36px; /* 增加输入框高度 */
            margin-bottom: 18px;
            outline: none;
            padding: 10px;
            font-size: 16px; /* 加大输入字体 */
            color: #fff; /* 输入框文本颜色 */
            background-color: #2D2D3F; /* 输入框背景色 */
            border: 1px solid #56536A; /* 增加边框 */
            border-radius: 4px;
        }

        input[type="submit"] {
            font-size: 16px; /* 提交按钮字体大小 */
            font-weight: bold; /* 提交按钮加粗 */
            color: #fff; /* 按钮字体颜色 */
            background-color: #4CAF50; /* 按钮绿色背景 */
            border: none; /* 按钮无边框 */
            border-radius: 4px;
            cursor: pointer;
            height: 38px; /* 提交按钮高度 */
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* 按钮悬停效果 */
        }

        .inputtext {
            text-align: left; /* 输入框文本左对齐 */
        }

        /* 链接样式 */
        a {
            font-size: 16px; /* 链接字体大小 */
            color: #FFD700; /* 链接颜色 */
            text-decoration: none; /* 去掉下划线 */
        }

        a:hover {
            text-decoration: underline; /* 悬停时添加下划线 */
        }
    </style>
    <script>
        function showUserForm() {
            document.getElementById('userForm').style.display = '';
            document.getElementById('merchantForm').style.display = 'none';
        }

        function showMerchantForm() {
            document.getElementById('merchantForm').style.display = '';
            document.getElementById('userForm').style.display = 'none';
        }

        function checkform(formType) {
            if (formType === 'user') {
                return text1submit() && text2submit() && text3submit();
            } else {
                return text4submit() && text5submit() && text6submit(); // 添加商家名称与密码确认验证
            }
        }

        function text1submit() {
            var id = document.userForm.loginid;
            if (id.value == "") {
                alert("账号不能为空哦\u263a");
                id.focus();
                return false;
            } else if (id.value.length < 6) {
                alert("账号不能小于6位");
                return false;
            } else return true;
        }

        function text2submit() {
            var pass = document.userForm.loginpass.value;
            var rpass = document.userForm.loginpass2.value;
            if (pass == "") {
                alert("密码不能为空哦\u263a");
                return false;
            } else if (pass != rpass) {
                alert("确认密码与密码输入不一致");
                return false;
            } else return true;
        }

        function text3submit() {
            var nname = document.userForm.loginname;
            if (nname.value == "") {
                alert("账号名不能为空哦\u263a");
                nname.focus();
                return false;
            } else return true;
        }

        // 商家的表单验证
        function text4submit() {
            var merchantName = document.merchantForm.merchantName;
            if (merchantName.value == "") {
                alert("商家名称不能为空哦\u263a");
                merchantName.focus();
                return false;
            }
            return true;
        }

        function text5submit() {
            var password = document.merchantForm.password;
            if (password.value == "") {
                alert("密码不能为空哦\u263a");
                return false;
            }
            return true;
        }

        function text6submit() {
            var rpassword = document.merchantForm.rpassword.value;
            var password = document.merchantForm.password.value;
            if (rpassword == "") {
                alert("确认密码不能为空哦\u263a");
                return false;
            } else if (rpassword != password) {
                alert("确认密码与密码输入不一致");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div id="logo6"><img src="img/logo6.png" width="350" height="100"></div>
<div class="regwd">
    <div class="form">
        <h2>欢迎注册</h2>
        <button onclick="showUserForm()">用户注册</button>
        <button onclick="showMerchantForm()">商家注册</button>

        <!-- 用户注册表单 -->
        <form name="userForm" id="userForm" action="loginwin" method="post" onsubmit="return checkform('user')" style="display:none;">
            <div class="inputtext"><input type="text" name="loginid" placeholder="请输入账号"></div>
            <div class="inputtext"><input type="password" name="loginpass" placeholder="请设置密码"></div>
            <div class="inputtext"><input type="password" name="loginpass2" placeholder="请再次输入密码"></div>
            <div class="inputtext"><input type="text" name="loginname" placeholder="请输入用户名"></div>
            <input type="submit" value="注册用户" class="">
        </form>

        <!-- 商家注册表单 -->
        <form name="merchantForm" id="merchantForm" action="merchantRegister" method="post" onsubmit="return checkform('merchant')" style="display:none;">
            <div class="inputtext"><input type="text" name="merchantID" placeholder="请输入商家账号"></div>
            <div class="inputtext"><input type="text" name="merchantName" placeholder="请输入商家名称"></div>
            <div class="inputtext"><input type="password" name="password" placeholder="请设置密码"></div>
            <div class="inputtext"><input type="password" name="rpassword" placeholder="请确认密码"></div>
            <input type="submit" value="注册商家" class="">
        </form>

        <!-- 跳转到登录界面的按钮 -->
        <p>已有账号？<a href="login.jsp">登录</a></p>
    </div>
</div>
</body>
</html>
