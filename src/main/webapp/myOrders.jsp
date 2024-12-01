<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.Order_Use" %>
<%@ page import="dao.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("upname"); // 获取用户名

    if (username == null) {
        out.println("<script>alert('请先登录'); window.location='login.jsp';</script>");
        return; // 如果未登录，重定向到登录页面
    }

    ArrayList<Order> orders = new ArrayList<>(); // 存储用户订单
    try {
        orders = Order_Use.getOrdersByUsername(username); // 获取当前用户的订单
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>查询订单时出现错误，请稍后再试。</p>");
        return; // 出现错误时停止执行
    }
%>

<html>
<head>
    <title>我的订单</title>
    <link href="css/main.css" rel="stylesheet">
    <link href="css/Shop_cat.css" rel="stylesheet">
    <link href="css/order.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
</head>
<body>
<%-- 页面头部 --%>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png"></div>
    <div class="top_up">欢迎您：<%= username %></div>
    <div class="navigation">
        <a href="cart.jsp">购物车</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="allShop.jsp">全部商品</a>
        <a href="logout">退出</a>
        <a href="manageGood.jsp" class="login-button">商家</a>
    </div>
</div>

<%-- 订单展示 --%>
<div class="main_down">
    <h1>我的订单</h1>

    <% if (orders.isEmpty()) { %>
    <p>您还没有订单。</p>
    <% } else { %>
    <table border="1">
        <tr>
            <th>选择</th>
            <th>商品名称</th>
            <th>地址</th>
            <th>数量</th>
            <th>价格</th>
            <th>商家名称</th>
        </tr>
        <% for (Order order : orders) { %>
        <tr>
            <td><input type="checkbox" class="orderCheckbox" value="<%= order.getIdString() %>"></td>
            <td><%= order.getGoodName() %></td>
            <td><%= order.getAddress() %></td>
            <td><%= order.getNumber() %></td>
            <td><%= order.getPrice() %></td>
            <td><%= order.getmerchantname() %></td>
        </tr>
        <% } %>
    </table>
    <input type="button" value="删除所选订单" id="deleteSelectedOrdersBtn" onclick="deleteSelectedOrders()"
           style="font-size: 16px; padding: 10px 20px; margin-top: 10px;"/>
    <% } %>
</div>

<script>
    function deleteSelectedOrders() {
        var selectedIds = [];
        // 获取所有选中的复选框
        document.querySelectorAll('.orderCheckbox:checked').forEach(function(checkbox) {
            selectedIds.push(checkbox.value); // 添加选中的订单 ID
        });

        if (selectedIds.length === 0) {
            alert("请至少选择一个订单进行删除。");
            return;
        }

        // 发送删除请求
        $.ajax({
            url: "orderBatchDelete", // 删除订单的 Servlet
            type: "POST",
            data: { ids: selectedIds }, // 发送所选 ID 数组
            traditional: true, // 使用传统方式传递数组
            success: function(response) {
                alert("订单已成功删除。");
                location.reload(); // 刷新页面以更新订单列表
            },
            error: function() {
                alert("删除订单时出现错误，请稍后再试。");
                alert(selectedIds.toString());
            }
        });
    }
</script>

<%-- 页面底部 --%>
</body>
</html>
