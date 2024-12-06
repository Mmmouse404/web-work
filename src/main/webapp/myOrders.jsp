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
    String goodName = request.getParameter("goodName");
    String address = request.getParameter("address");

    try {
        if ((goodName == null || goodName.isEmpty()) && (address == null || address.isEmpty())) {
            orders = Order_Use.getOrdersByUsername(username); // 获取当前用户的订单
        } else {
            // 根据商品名称和地址进行查询
            orders = Order_Use.getOrdersFiltered(username, goodName, address); // 实现此方法
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>查询订单时出现错误，请稍后再试。</p>");
        return; // 出现错误时停止执行
    }
%>

<html>
<head>
    <title>我的订单</title>
    <style>
        body {
            background: url("img/bg3.jpg") repeat;
        }
    </style>
    <link href="css/main.css" rel="stylesheet">
    <link href="css/Shop_cat.css" rel="stylesheet">
    <link href="css/order.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        .main_down {
            max-height: 400px; /* 设置最大高度 */
            overflow-y: auto; /* 启用垂直滚动条 */
        }
        .table-scroll {
            overflow-x: auto; /* 启用水平滚动条 */
            width: 100%;
        }
        .search-container {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<%-- 页面头部 --%>
<div class="main_head">
    <div class="logo"><img src="img/mouse.png"></div>
    <div class="top_up" style="right: 30px;top: 50px;position: absolute;">欢迎您：<%= username %></div>
    <div class="navigation">
        <a href="userProfile.jsp">个人中心</a>
        <a href="cart.jsp">购物车</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="allShop.jsp">全部商品</a>
        <a href="logout">退出</a>
        <a href="manageGood.jsp" class="login-button">商家</a>
    </div>
    <%-- 查询部分 --%>

</div>


<div class="search-container" style="left: 20%;top: 1%;position: absolute;">
    <label for="goodName">商品名称:</label>
    <input type="text" id="goodName" placeholder="输入商品名称">
    <label for="address">地址:</label>
    <input type="text" id="address" placeholder="输入地址">
    <input type="button" value="查询" onclick="queryOrders()">
</div>
<%-- 订单展示 --%>
<div class="main_down">
    <h1>我的订单</h1>

    <% if (orders.isEmpty()) { %>
    <p>您还没有订单。</p>
    <% } else { %>
    <div class="table-scroll">
        <table border="1">
            <tr>
                <th>选择</th>
                <th>商品名称</th>
                <th>地址</th>
                <th>数量</th>
                <th>价格</th>
                <th>商家名称</th>
                <th>订单状态</th>
            </tr>
            <% for (Order order : orders) { %>
            <tr>
                <td><input type="checkbox" class="orderCheckbox" value="<%= order.getIdString() %>"></td>
                <td><%= order.getGoodName() %></td>
                <td><%= order.getAddress() %></td>
                <td><%= order.getNumber() %></td>
                <td><%= order.getPrice() %></td>
                <td><%= order.getmerchantname() %></td>
                <td class="status
                            <% if ("未发货".equals(order.getStatus())) { %>
                                status-pending
                            <% } else if ("已发货".equals(order.getStatus())) { %>
                                status-shipped
                            <% } else if ("已收货".equals(order.getStatus())) { %>
                                status-delivered
                            <% } %>
                            ">
                    <%= order.getStatus() %>
                </td>
                <% if ("已发货".equals(order.getStatus())) { %>
                <td>
                    <button onclick="receiveOrder(<%= order.getId() %>)">收货</button>
                </td>
                <% } else { %>
                <td></td>
                <% } %>
            </tr>
            <% } %>
        </table>
    </div>
    <div class="button-container">
        <input type="button" value="删除所选订单" id="deleteSelectedOrdersBtn" class="add-cart-button" onclick="deleteSelectedOrders()"/>
        <button class="add-cart-button" onclick="history.back()">返回</button> <!-- 返回按钮 -->
    </div>
    <% } %>

</div>

<script>
    function receiveOrder(orderId) {
        if (confirm("您确定要收货吗？")) {
            $.ajax({
                url: "shipOrder", // 调用 shipOrder 的 Servlet
                type: "POST",
                data: {
                    orderId: orderId,
                    status: "已收货" // 传递新的状态
                },
                success: function(response) {
                    if (response === "success") {
                        alert("收货成功。");
                        location.reload(); // 刷新页面以更新订单列表
                    } else {
                        alert("收货失败，请稍后再试。");
                    }
                },
                error: function() {
                    alert("收货请求失败，请稍后再试。");
                }
            });
        }
    }

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

    function queryOrders() {
        var goodName = document.getElementById("goodName").value;
        var address = document.getElementById("address").value;

        $.ajax({
            url: "myOrders.jsp", // 直接请求当前 JSP 页面
            type: "GET",
            data: {
                goodName: goodName,
                address: address
            },
            success: function(response) {
                document.querySelector('.main_down').outerHTML = response; // 更新页面内容
            },
            error: function() {
                alert("查询请求失败，请稍后再试。");
            }
        });
    }
</script>

<%-- 页面底部 --%>
</body>
</html>
