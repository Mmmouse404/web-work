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
        }
        #login h1 {
            color: #fff;
            text-shadow: 0 0 10px;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }
        input {
            width: 278px;
            height: 30px;
            margin-bottom: 18px;
            outline: none;
            padding: 10px;
            font-size: 13px;
            color: #fff;
            text-shadow: 1px 1px 1px;
            border-top: 1px solid #312E3D;
            border-left: 1px solid #312E3D;
            border-right: 1px solid #312E3D;
            border-bottom: 1px solid #56536A;
            border-radius: 4px;
            background-color: #2D2D3F;
        }
        .but {
            height: 30px;
            width: 90px;
            background: rgba(255, 255, 255, 0.01);
            color: #FFFFFF;
            text-shadow: 0 0 0 rgba(0, 0, 255, 0.5);
            cursor: pointer;
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
<div id="logo6"><img src="img/logo6.png" width="350" height="100"></div>
<div id="login">
    <h1>登录</h1>
    <button onclick="showUserLogin()">用户登录</button>
    <button onclick="showMerchantLogin()">商家登录</button>

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
</div>
</body>
</html>
