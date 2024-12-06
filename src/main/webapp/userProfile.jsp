<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.User_Use" %>
<%@ page import="java.sql.SQLException" %>
<jsp:include page="increaseMoney.jsp" />
<%
    // 获取当前用户的信息
    String username = (String) session.getAttribute("upname");
    String email = "";
    double userMoney = 0.0;

    if (username != null) {
        try {
            // 获取用户的信息
            email = User_Use.getUserEmail(username);
            userMoney = User_Use.getUserMoney(username);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        out.println("<p>请先登录以访问个人中心。</p>");
        return; // 用户未登录，停止执行
    }
%>

<html>
<style>
    body {
        background: url("img/bg3.jpg") repeat;
    }
</style>
<head>
    <title>个人中心</title>
    <link href="css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="css/Gwc.css"> <!-- 可添加样式 -->
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/ajax.js"></script>
</head>
<body>
<h1>个人中心</h1>

<div class="user-info" style="display:flex; justify-content: space-between;">
    <div>
    <h3>用户信息</h3>
    <p>用户名: <input type="text" id="userName" value="<%= username %>" disabled /></p>
    <p>邮箱: <input type="text" id="email" value="<%= email %>" /></p>
    <p>新密码: <input type="password" id="newPassword" placeholder="输入新密码"/></p>
    <button onclick="updateUserInfo()">更新信息</button>
    <p>账户余额: <input type="number" id="userMoney" value="<%= userMoney %>" disabled /> 元</p>
    <input type="button" value="增加金额" id="increaseMoneyBtn" onclick="showIncreaseMoneyDialog()"/> <!-- 调用函数显示对话框 -->

    <span id="message"></span>
    </div>
<div class="user-actions"  style="display:flex; justify-content: center;">
    <button onclick="window.location.href='mainFrame.jsp'">推荐商品</button>
    <button onclick="window.location.href='allShop.jsp'">全部商品</button>
    <button onclick="window.location.href='cart.jsp'">购物车</button>
    <button onclick="window.location.href='myOrders.jsp'">订单</button>
</div>
</div>
<script>
    function showIncreaseMoneyDialog() {
        document.getElementById("increaseMoneyDialog").style.display = "block"; // 显示弹出框
    }
    function updateUserInfo() {
        var email = document.getElementById("email").value;
        var newPassword = document.getElementById("newPassword").value;

        // AJAX请求更新用户信息
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateUserInfo", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onload = function() {
            if (xhr.status === 200) {
                document.getElementById("message").innerText = "信息更新成功！";
            } else {
                document.getElementById("message").innerText = "信息更新失败，请重试。";
            }
        };

        // 发送数据
        var params = "username=<%= username %>&email=" + encodeURIComponent(email);
        if (newPassword) {
            params += "&password=" + encodeURIComponent(newPassword);
        }
        xhr.send(params);
    }
</script>
</body>
</html>
