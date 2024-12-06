<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.User_Use" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<jsp:include page="increaseMoney.jsp" />
<%
    String username = (String) session.getAttribute("upname");
    double userMoney = 0.0;

    if (username != null) {
        try {
            userMoney = User_Use.getUserMoney(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // 分页逻辑
    int pageSize = 10; // 每页显示的商品数量
    int currentPage = 1; // 当前页

    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }

    // 搜索功能
    String searchSort = request.getParameter("search-sort");
    String keywords = request.getParameter("keywords");

    int totalItems; // 声明一个变量保存商品总数
    List<Goodlist> goodsList;

    // 如果有搜索参数，调用带条件的方法；否则，获取所有商品
    if (searchSort != null || (keywords != null && !keywords.isEmpty())) {
        totalItems = Goodlist_Use.getFilteredGoodNumber(searchSort, keywords); // 获取符合条件的商品总数
        goodsList = Goodlist_Use.getGoodListWithPagination(searchSort, keywords, currentPage, pageSize);
    } else {
        totalItems = Goodlist_Use.getGoodNumber(); // 获取商品总数
        goodsList = Goodlist_Use.getGoodListWithPagination("", "", currentPage, pageSize); // 默认获取所有商品
    }

    int totalPages = (int) Math.ceil(totalItems / (double) pageSize); // 计算总页数

    // 将变量存储到请求属性中
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("goodsList", goodsList);
    request.setAttribute("totalPages", totalPages);
%>

<html>
<style>
    body {
        background: url("img/bg3.jpg") repeat;
    }
</style>
<head>
    <title>全部商品</title>
    <link rel="stylesheet" href="css/allShop.css">

</head>
<body>
<div class="main_head" style="display: flex; align-items: center; justify-content: flex-start;">
    <div class="logo" style="width: 50px;height: 50px;"><img src="img/mouse.png" alt="Logo"></div>
    <!-- 搜索表单 -->
    <div class="search-wrap" style="left: 20%;position: absolute;">
        <form action="allShop.jsp" method="get"> <!-- 提交查询 -->
            <label>选择分类:</label>
            <select name="search-sort">
                <option value="">全部</option>
                <%
                    ArrayList<String> kinds = Goodlist_Use.getAllKinds(); // 从数据库获取所有分类
                    for (String kind : kinds) {
                %>
                <option value="<%= kind %>" <%= searchSort != null && searchSort.equals(kind) ? "selected" : "" %>><%= kind %></option>
                <%
                    }
                %>
            </select>

            <label >关键字:</label>
            <input type="text" name="keywords" placeholder="输入关键字" value="<%= keywords != null ? keywords : "" %>">
            <input type="submit" value="查询">
        </form>
    </div>
    <style>
        body {
            background: url("img/bg3.jpg") repeat;
        }
    </style>
    <div class="top_up">欢迎您：<%= username != null ? username : "游客" %>
        <% if (username != null) { %>
        | 账户余额：<%= userMoney %>元
        <input type="button" value="增加金额" id="increaseMoneyBtn" onclick="showIncreaseMoneyDialog()"/> <!-- 调用函数显示对话框 -->
        <% } %>
    </div>
    <div class="navigation">
        <a href="userProfile.jsp">个人中心</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="allShop.jsp">全部商品</a>
        <a href="cart.jsp">购物车</a>
        <a href="myOrders.jsp">订单</a>
        <% if (username != null) { %>
        <a href="logout">退出</a> <!-- 退出登录链接 -->
        <% } else { %>
        <a href="login.jsp">登录</a> <!-- 登录链接 -->
        <% } %>
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增商家按钮 -->
    </div>
</div>

<div class="main_down">



    <div class="shop_container"> <!-- 商品容器 -->
        <c:forEach items="${goodsList}" var="a">
            <div class="product-card" style="border: 1px solid #ccc; padding: 10px; margin: 10px; text-align: center;">
                <a href="mouseShop.jsp?Sid=${a.getId()}">
                    <img class="product-image" src="<c:out value="${a.getImage()}" />" alt="<c:out value="${a.getGoodName()}" />" />
                </a>
                <div class="product-info">
                    <span class="s1"><c:out value="${a.getGoodName()}" /></span><br>
                    <span class="s2">价格：<c:out value="${a.getPrice()}" />元</span>
                    <span class="s3">限量：<c:out value="${a.getStock()}" />件</span>
                </div>
                <div class="center">
                    <a href="mouseShop.jsp?Sid=${a.getId()}">
                        <input type="button" value="详情" class="add-to-cart" />
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 翻页按钮 -->
    <div class="pagination" style="margin-top: 20px;margin-left: 20px; display: flex; justify-content: center;">
        <c:if test="${currentPage > 1}">
            <button class="back-button" onclick="window.location.href='allShop.jsp?page=${currentPage - 1}'">上一页</button>
        </c:if>
        <c:if test="${currentPage < totalPages}">
            <button class="back-button" onclick="window.location.href='allShop.jsp?page=${currentPage + 1}'">下一页</button>
        </c:if>
        <button class="back-button" onclick="history.back()" style="margin-right: 20px;">返回</button> <!-- 返回按钮 -->
    </div>
</div>
</body>
</html>
