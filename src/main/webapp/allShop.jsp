<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="java.util.List" %>

<%
    // 检查用户是否已登录
    if (session.getAttribute("upname") == null) {
        response.sendRedirect("login.jsp"); // 如果未登录，重定向到登录页面
        return; // 结束当前页面的执行
    }
%>

<html>
<head>
    <title>全部商品</title>
    <link rel="stylesheet" href="css/allShop.css">
</head>
<body>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png" alt="Logo"></div>
    <div class="top_up">
        欢迎您：<c:out value="${sessionScope.upname}"/>
        <img src="img/grzx.png" width="50" height="50" />
        <a href="cart.jsp">购物车</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="logout">退出</a> <!-- 退出登录链接 -->
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增登录按钮 -->
    </div>
</div>

<div class="main_down">
    <h1>全部商品:</h1>
    <div class="shop_container"> <!-- 商品容器 -->
        <c:set var="goodList" value="${Goodlist_Use.getGoodList()}" />
        <c:forEach items="${goodList}" var="a">
            <div class="product-card"> <!-- 商品卡片 -->
                <a href="mouseShop.jsp?Sid=${a.getId()}">
                    <img class="product-image" src="<c:out value="${a.getImage()}" />" alt="<c:out value="${a.getGoodName()}" />" />
                </a>
                <div class="product-info">
                    <span class="s1"><c:out value="${a.getGoodName()}" /></span><br>
                    <span class="s2">￥<c:out value="${a.getPrice()}" /></span><br>
                    <span class="s3"><c:out value="${a.getStock()}" />件</span><br>
                    <span class="s4"><c:out value="${a.getMerchantName()}" /></span>
                </div>
                <div class="center">
                    <a href="mouseShop.jsp?Sid=${a.getId()}">
                        <input type="button" value="购买" class="qbtn" />
                    </a>
                    <input type="button" value="加入购物车" class="add-to-cart" /> <!-- 加入购物车按钮 -->
                </div>
            </div>
        </c:forEach>
    </div>

</div>
</body>
</html>
