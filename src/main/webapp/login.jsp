<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <style>
        html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-style: italic;
        }
        body {
            width: 100%;
            height: 100%;
            font-family: 'Open Sans', sans-serif;
            margin: 0;
            background: url("img/bg.jpg") no-repeat;
            background-size: cover;
        }
        #login {
            position: absolute;
            top: 50%;
            left: 50%;
            margin: -150px 0 0 -150px;
            width: 300px;
            height: auto;
            text-align: center;
            background-color: white; /* 设置背景为白色 */
            padding: 20px; /* 添加内边距 */
            border-radius: 8px; /* 圆角效果 */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* 添加阴影 */
        }
        #login h1 {
            color: #333; /* 设置标题颜色 */
            margin-bottom: 20px;
        }
        input {
            width: 278px;
            height: 30px;
            margin-bottom: 18px;
            outline: none;
            padding: 10px;
            font-size: 13px;
            color: #333; /* 设置输入框文字颜色 */
            border: 1px solid #ccc; /* 边框颜色 */
            border-radius: 4px; /* 圆角效果 */
            background-color: #f9f9f9; /* 输入框背景色 */
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
        function showUserLogin() {
            document.getElementById('userLoginForm').style.display = '';
            document.getElementById('merchantLoginForm').style.display = 'none';
        }

        function showMerchantLogin() {
            document.getElementById('merchantLoginForm').style.display = '';
            document.getElementById('userLoginForm').style.display = 'none';
        }
    </script>
</head>
<body>
<div id="logo6"><img src="img/mouse.png" width="128" height="128"></div>
<div id="login">
    <h1>帽子老鼠的小店</h1>
    <button class="but" onclick="showUserLogin()">用户登录</button>
    <button class="but" onclick="showMerchantLogin()">商家登录</button>

    <!-- 用户登录表单 -->
    <form id="userLoginForm" method="post" action="upwin" style="display: none;">
        <input type="text" required="required" placeholder="账号" name="upid">
        <input type="password" required="required" placeholder="密码" name="uppass">
        <button class="but" type="submit">登录</button>
    </form>

    <!-- 商家登录表单 -->
    <form id="merchantLoginForm" method="post" action="merchantLogin" style="display: none;">
        <input type="text" required="required" placeholder="商家账号" name="merchantID">
        <input type="password" required="required" placeholder="密码" name="password">
        <button class="but" type="submit">登录</button>
    </form>

    <p>还没有账号？<a href="register.jsp">去注册</a></p> <!-- 添加跳转到注册页面的链接 -->
</div>
</body>
</html>
