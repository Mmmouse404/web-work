<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Order" %>
<%@ page import="dao.Order_Use" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>订单管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        function batchDelete() {
            var ids = [];
            // 获取所有选中的复选框
            $("input[name='checkbox']:checked").each(function() {
                var orderId = $(this).closest('tr').find('td:eq(1)').text(); // 获取订单编号
                ids.push(orderId); // 将订单 ID 添加到数组
            });

            if (ids.length === 0) {
                alert("请至少选择一件订单进行删除！");
                return; // 如果没有选中订单，结束函数
            }

            // 发送 AJAX 请求到后端进行删除
            $.ajax({
                url: "orderBatchDelete",
                type: "POST",
                data: { ids: ids }, // 传递选中的订单 ID
                traditional: true,
                success: function(response) {
                    alert("订单已成功删除");
                    window.location.reload(); // 刷新页面
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        }

        // 发货功能或状态查看的处理函数
        function shipOrder(orderId, username) { // 添加 username 参数
            var confirmation = confirm("确认发货吗？");
            if (confirmation) {
                alert(username);
                $.ajax({
                    url: "shipOrder", // 后端处理发货的 Servlet
                    type: "POST",
                    data: { action:'shipOrder' ,orderId: orderId, username: username ,status: "已发货" }, // 传递订单 ID 和用户名
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

        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
            });
        });
        $(function () {
            $("#c1").click(function () {
                $("input[name='checkbox']").prop("checked", this.checked);
            });
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container clearfix">
    <jsp:include page="sidebar.jsp" />
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><a href="manageGood.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">订单管理</span></div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="#">新增订单</a>
                        <a id="batchDel" href="#" onclick="batchDelete();">批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr >
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox" style="align-items: center;" id="c1">全选</th>

                            <th>订单编号</th>
                            <th>订单商品</th>
                            <th>订单人</th>
                            <th>地址</th>
                            <th>数量</th>
                            <th>总价</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        <%
                            String merchantName = (String) session.getAttribute("merchantname"); // 获取当前商家名称
                            ArrayList<Order> orderList = null; // 获取当前商家的订单
                            try {
                                orderList = Order_Use.getOrdersByMerchant(merchantName);
                            } catch (SQLException e) {
                                e.printStackTrace();
                                throw new RuntimeException(e);
                            }

                            for (Order order : orderList) {
                        %>
                        <tr>
                            <td class="tc"><input name="checkbox" value="<%= order.getId() %>" type="checkbox"></td>
                            <td><%= order.getId() %></td>
                            <td><%= order.getGoodName() %></td>
                            <td><%= order.getUserName() %></td>
                            <td><%= order.getAddress() %></td>
                            <td><%= order.getNumber() %></td>
                            <td><%= order.getPrice() %>元</td>
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
                            <td>
                                <% if ("未发货".equals(order.getStatus())) { %>
                                <input type="button" value="发货" onclick="shipOrder(<%= order.getId() %>, '<%= order.getUserName() %>')" /> <!-- 将用户 email 传入 -->
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="list-page">总计<%= orderList.size() %> 条</div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
