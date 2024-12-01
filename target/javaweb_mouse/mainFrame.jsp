<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.User_Use" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
    <title>小卖部主页面</title>
    <link href="css/main.css" rel="stylesheet">
</head>
<body>

<%--小卖部顶部页面--%>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png" alt="小卖部 Logo"></div>
    <div class="top_up">欢迎您：<%= username != null ? username : "游客" %>
        <% if (username != null) { %>
        | 账户余额：<%= userMoney %>元
        <input type="button" value="增加金额" id="increaseMoneyBtn" onclick="showIncreaseMoneyDialog()"/> <!-- 调用函数显示对话框 -->

        <% } %>
    </div>
    <div class="navigation">
        <a href="cart.jsp">购物车</a>
        <a href="myOrders.jsp">订单</a>
        <a href="allShop.jsp">全部商品</a>
        <% if (username != null) { %>
        <a href="logout">退出</a> <!-- 退出登录链接 -->
        <% } else { %>
        <a href="login.jsp">登录</a> <!-- 登录链接 -->
        <% } %>
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增登录按钮 -->
    </div>
</div>

<%--商品列表展示--%>
<div class="main_down">
    <h1 class="tit1">店长推荐:</h1>
    <div class="shop_table">
        <table>
            <tr>
                <%
                    ArrayList<Goodlist> arr = null;
                    try {
                        arr = Goodlist_Use.getGoodList();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }

                    // 只展示前五个商品，确保不出现索引越界
                    for (int i = 0; i < Math.min(5, arr.size()); i++) {
                %>
                <td>
                    <a href="<%="mouseShop.jsp?Sid=" + arr.get(i).getId()%>">
                        <img src="<%= arr.get(i).getImage() %>" alt="<%= arr.get(i).getGoodName() %>">
                    </a>
                    <div class="product-info">
                        <span class="s1"><%= arr.get(i).getGoodName() %></span><br>
                        <span class="s2">￥<%= arr.get(i).getPrice() %></span>
                    </div>
                </td>
                <%
                    }
                %>
            </tr>
        </table>
    </div>
</div>

</body>
</html>
