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
            background: url("img/bg.jpg") no-repeat;
            background-size: cover; /* 背景覆盖整个页面 */
        }

        .regwd {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.9); /* 半透明背景 */
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3); /* 添加阴影效果 */
            text-align: center; /* 内容居中 */
        }

        h2 {
            font-size: 24px; /* 增加标题字体大小 */
            color: #333; /* 标题文字颜色 */
            margin-bottom: 20px;
        }

        input {
            width: calc(100% - 20px); /* 减去 padding */
            height: 36px; /* 增加输入框高度 */
            margin-bottom: 18px;
            outline: none;
            padding: 10px;
            font-size: 16px; /* 加大输入字体 */
            border: 1px solid #ccc; /* 增加边框 */
            border-radius: 4px;
            background-color: #f8f8f8; /* 输入框背景色 */
        }

        input[type="submit"] {
            font-size: 16px; /* 提交按钮字体大小 */
            font-weight: bold; /* 提交按钮加粗 */
            color: #fff; /* 按钮字体颜色 */
            background-color: #4CAF50; /* 按钮绿色背景 */
            border: none; /* 按钮无边框 */
            border-radius: 4px;
            cursor: pointer;
            height: 40px; /* 提交按钮高度 */
            width: 100%; /* 按钮宽度 */
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* 按钮悬停效果 */
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

        #logo5 {
            position: absolute;
            left: 2%;
        }
        .but {
            height: 30px;
            width: 120px; /* 按钮更宽 */
            background: mediumseagreen; /* 设置绿色按钮背景 */
            color: #FFFFFF;
            cursor: pointer;
            border: none; /* 去掉按钮边框 */
            border-radius: 5px; /* 圆角效果 */
            transition: background-color 0.3s; /* 添加过渡效果 */
            margin: 10px 0; /* 按钮之间和下面的输入框有空间 */
        }
        .but:hover {
            background: darkgreen; /* 悬停效果 */
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
            alert(document.userForm.email.value);
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
            var merchantname = document.merchantForm.merchantname;
            if (merchantname.value == "") {
                alert("商家名称不能为空哦\u263a");
                merchantname.focus();
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
<div id="logo5"><img src="img/mouse.png" width="128" height="128" top="1%"></div>
<div class="regwd">
    <div class="form">
        <h2>欢迎注册</h2>
        <button  class="but" onclick="showUserForm()">用户注册</button>
        <button class="but" onclick="showMerchantForm()">商家注册</button>

        <!-- 用户注册表单 -->
        <form name="userForm" id="userForm" action="loginwin" method="post" onsubmit="return checkform('user')" style="display:none;">
            <input type="text" name="loginid" placeholder="请输入账号">
            <input type="password" name="loginpass" placeholder="请设置密码">
            <input type="password" name="loginpass2" placeholder="请再次输入密码">
            <input type="text" name="loginname" placeholder="请输入用户名">
            <input type="text" name="email" placeholder="请输入电子邮件（可选）"> <!-- 添加电子邮件输入框 -->
            <input type="submit" value="注册用户" class="but">
        </form>

        <!-- 商家注册表单 -->
        <form name="merchantForm" id="merchantForm" action="merchantRegister" method="post" onsubmit="return checkform('merchant')" style="display:none;">
            <input type="text" name="merchantID" placeholder="请输入商家账号">
            <input type="text" name="merchantname" placeholder="请输入商家名称">
            <input type="password" name="password" placeholder="请设置密码">
            <input type="password" name="rpassword" placeholder="请确认密码">
            <input type="submit" value="注册商家" class="but">
        </form>

        <!-- 跳转到登录界面的按钮 -->
        <p>已有账号？<a href="login.jsp">登录</a></p>
    </div>
</div>
</body>
</html>
