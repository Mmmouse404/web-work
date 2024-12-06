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
    <style>
        body {
            background: url("img/bg3.jpg") repeat;
        }
    </style>
    <script>
        function showIncreaseMoneyDialog() {
            document.getElementById("increaseMoneyDialog").style.display = "block"; // 显示弹出框
        }
    </script>
    <title>小卖部主页面</title>
    <link href="css/main.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/ajax.js"></script>
</head>
<body>

<%--小卖部顶部页面--%>
<div class="main_head" style="display: flex; align-items: center; justify-content: flex-start;">
    <div class="logo" style="width: 50px;height: 50px;"><img src="img/mouse.png" alt="小卖部 Logo"></div>
    <div class="top_up" style="top: 40px;">>欢迎您：<%= username != null ? username : "游客" %>
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
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增登录按钮 -->
    </div>
</div>

<%--商品列表展示--%>
<%--商品列表展示--%>
<div class="main_down">
    <h1 class="tit1">店长推荐:</h1>
    <div class="shop_table">
        <table>
            <tr>
                <%
                    ArrayList<Goodlist> arr = null;
                    try {
                        arr = Goodlist_Use.getRandomGoods(6); // 随机获取6个商品
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }

                    // 确保不出现索引越界
                    for (Goodlist good : arr) {
                %>
                <td>
                    <div class="product-card" style="border: 1px solid #ccc; border-radius: 5px; padding: 10px; margin: 10px; text-align: center;">
                        <a href="<%="mouseShop.jsp?Sid=" + good.getId()%>">
                            <img style="width:200px; height:200px; object-fit:contain ; border-radius: 5px;" src="<%= good.getImage() %>" alt="<%= good.getGoodName() %>">
                        </a>
                        <div class="product-info">
                            <span class="s1"><%= good.getGoodName() %></span><br>
                            <span class="s2">￥<%= good.getPrice() %></span>
                        </div>
                    </div>
                </td>
                <%
                    }
                %>
            </tr>
        </table>
        <button class="back-button" onclick="history.back()" style="margin-right: 20px;">返回</button> <!-- 返回按钮 -->
        <button class="back-button" onclick="location.reload()" style="margin-right: 20px;">刷新</button>
    </div>

</div>


</body>
</html>
