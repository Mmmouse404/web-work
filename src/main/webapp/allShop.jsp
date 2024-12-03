<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.User_Use" %>
<%@ page import="java.sql.SQLException" %>
<jsp:include page="increaseMoney.jsp" />
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("upname"); // 获取用户名
    double userMoney = 0.0; // 存储用户余额

    // 如果用户已登录，获取用户的金额
    if (username != null) {
        try {
            userMoney = User_Use.getUserMoney(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
%>

<html>
<head>
    <script>
        function showIncreaseMoneyDialog() {
            document.getElementById("increaseMoneyDialog").style.display = "block"; // 显示弹出框
        }
    </script>
    <title>全部商品</title>
    <link rel="stylesheet" href="css/allShop.css">
</head>
<body>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png" alt="Logo"></div>
    <div class="top_up">欢迎您：<%= username != null ? username : "游客" %>
        <% if (username != null) { %>
        | 账户余额：<%= userMoney %>元
        <input type="button" value="增加金额" id="increaseMoneyBtn" onclick="showIncreaseMoneyDialog()"/> <!-- 调用函数显示对话框 -->

        <% } %>
    </div>
    <div class="navigation">
        <a href="cart.jsp">购物车</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="myOrders.jsp">订单</a>
        <% if (username != null) { %>
        <a href="logout">退出</a> <!-- 退出登录链接 -->
        <% } else { %>
        <a href="login.jsp">登录</a> <!-- 登录链接 -->
        <% } %>
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增登录按钮 -->
    </div>
</div>

<div class="main_down">
    <h1>全部商品:</h1>
    <div class="shop_container"> <!-- 商品容器 -->
        <c:set var="Goodlist" value="${Goodlist_Use.getGoodList()}" />
        <c:forEach items="${Goodlist}" var="a">
            <div class="product-card"> <!-- 商品卡片 -->
                <a href="mouseShop.jsp?Sid=${a.getId()}">
                    <img class="product-image" src="<c:out value="${a.getImage()}" />" alt="<c:out value="${a.getGoodName()}" />" />
                </a>
                <div class="product-info">
                    <span class="s1"><c:out value="${a.getGoodName()}" /></span>
                    <span class="s2">价格：<c:out value="${a.getPrice()}" />元</span>
                    <span class="s3">限量：<c:out value="${a.getStock()}" />件</span>
                </div>
                <div class="center">
                    <a href="mouseShop.jsp?Sid=${a.getId()}">
                        <input type="button" value="详情" class="add-to-cart" /> <!-- 加入购物车按钮 -->
                    </a>

                </div>
            </div>
        </c:forEach>
    </div>

</div>
</body>
</html>
