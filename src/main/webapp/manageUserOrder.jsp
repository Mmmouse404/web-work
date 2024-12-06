<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.User_Use" %>
<%@ page import="dao.Order_Use" %>
<%@ page import="dao.Order" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.User" %>

<%
    // 获取所有用户
    List<User> userList = new ArrayList<>();
    try {
        userList = User_Use.getListWithVOFromRS(); // 假设此方法返回所有用户
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>用户订单管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center; /* 使文字居中 */
        }
        th {
            background-color: #f2f2f2;
        }
        .status-pending {
            background: yellow; /* 未发货的状态 */
            color: black;
        }
        .status-shipped {
            color: blue; /* 已发货的状态 */
        }
        .status-delivered {
            color: green; /* 已收货的状态 */
        }
    </style>
    <script>
        $(document).ready(function(){
            $("tr.user-row").click(function(){
                $(this).next(".order-details").toggle(); // 切换显示用户的订单细节
            });

            // 搜索功能
            $("#searchUser").on("input", function() {
                var searchText = $(this).val().toLowerCase();
                $(".user-row").each(function() {
                    var userName = $(this).find("td:first").text().toLowerCase();
                    if (userName.includes(searchText)) {
                        $(this).show();
                        $(this).next(".order-details").show();
                    } else {
                        $(this).hide();
                        $(this).next(".order-details").hide();
                    }
                });
            });
        });
        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
            });
        });
        function shipOrder(orderId, username) {
            var confirmation = confirm("确认发货吗？");
            if (confirmation) {
                $.ajax({
                    url: "shipOrder", // 后端处理发货的 Servlet
                    type: "POST",
                    data: { action: 'shipOrder', orderId: orderId, username: username, status: "已发货" },
                    traditional: true,
                    success: function(response) {
                        alert("发货成功！");
                        window.location.reload(); // 刷新页面以更新状态显示
                    },
                    error: function() {
                        alert("发货失败，请重试");
                    }
                });
            }
        }
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container clearfix">
    <jsp:include page="sidebar.jsp" />
    <div class="main-wrap">
        <div class="result-wrap">
            <div class="result-title">
                <div class="result-list">
                    <h2>用户订单管理（点击用户可查看订单详情）</h2>
                    <input type="text" id="searchUser" placeholder="搜索用户名">
                </div>
            </div>
            <div class="result-content">
                <table class="result-tab">
                    <tr style="text-align: center;">
                        <th style="text-align: center;">用户名称</th>
                        <th style="text-align: center;">订单数量</th>
                        <th style="text-align: center;">总消费额</th>
                    </tr>
                    <%
                        for (User user : userList) {
                            String userName = user.getName(); // 获取用户名
                            List<Order> orderList = Order_Use.getOrdersByUsername(userName); // 获取该用户的所有订单
                            double totalAmount = 0.0;

                            // 计算该用户的总金额
                            for (Order order : orderList) {
                                totalAmount += Double.parseDouble(order.getPrice());
                            }
                    %>
                    <tr class="user-row">
                        <td><%= userName %></td>
                        <td><%= orderList.size() %></td> <!-- 订单数量 -->
                        <td><%= totalAmount %>元</td>  <!-- 总金额 -->
                    </tr>
                    <tr class="order-details" style="display: none;">
                        <td colspan="3">
                            <table>
                                <tr style="text-align: center;">
                                    <th style="text-align: center;">订单编号</th>
                                    <th style="text-align: center;">订单商品</th>
                                    <th style="text-align: center;">地址</th>
                                    <th style="text-align: center;">数量</th>
                                    <th style="text-align: center;">状态</th>
                                    <th style="text-align: center;">总价</th>
                                    <th style="text-align: center;">操作</th>
                                </tr>
                                <%
                                    for (Order order : orderList) { // 遍历该用户的所有订单
                                %>
                                <tr>
                                    <td><%= order.getId() %></td>
                                    <td><%= order.getGoodName() %></td>
                                    <td><%= order.getAddress() %></td>
                                    <td><%= order.getNumber() %></td>
                                    <td class="status
                                        <% if ("未发货".equals(order.getStatus())|| order.getStatus() == null) { %>
                                            status-pending
                                        <% } else if ("已发货".equals(order.getStatus())) { %>
                                            status-shipped
                                        <% } else if ("已收货".equals(order.getStatus())) { %>
                                            status-delivered
                                        <% } %>
                                        ">
                                        <%= order.getStatus()!= null ? order.getStatus() : "未发货" %>
                                    </td>
                                    <td><%= order.getPrice() %>元</td>
                                    <td>
                                        <% if ("未发货".equals(order.getStatus())|| order.getStatus() == null) { %>
                                        <input type="button" value="发货" onclick="shipOrder(<%= order.getId() %>, '<%= order.getUserName() %>')" />
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </table>
                        </td>
                    </tr>
                    <%
                        } // 结束每个用户循环
                    %>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
