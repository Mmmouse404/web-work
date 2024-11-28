<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Order" %>
<%@ page import="dao.Order_Use" %>
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
                url: "orderBatchDelete", // 假设这是处理批量删除的 Servlet
                type: "POST",
                data: { ids: ids }, // 传递选中的订单 ID
                traditional: true, // 使用传统方式传递数组
                success: function(response) {
                     {
                        alert("订单已成功删除");
                        window.location.reload(); // 刷新页面
                    }
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        }

        $(function () {
            $("#c1").click(function () {
                $("input[name='checkbox']").prop("checked", this.checked);
            });

            $(".sidebar-content > ul > li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function() {
                $(".sidebar-content > ul").toggle();
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
            <div class="crumb-list"><a href="manageUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">订单管理</span></div>
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
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" type="checkbox" id="c1">全选</th>
                            <th>订单编号</th>
                            <th>订单商品</th>
                            <th>订单人</th>
                            <th>地址</th>
                            <th>数量</th>
                            <th>总价</th>
                            <th>状态</th>
                        </tr>
                        <%
                            String merchantName = (String) session.getAttribute("merchantname"); // 获取当前商家名称
                            ArrayList<Order> RR = Order_Use.getOrdersByMerchant(merchantName); // 获取当前商家的订单
                            int mnum = RR.size(); // 获取订单数量
                            for (Order aa : RR) {
                        %>
                        <tr>
                            <td class="tc"><input name="checkbox" type="checkbox"></td>
                            <td><%= aa.getId() %></td>
                            <td><%= aa.getGoodName() %></td>
                            <td><%= aa.getUserName() %></td>
                            <td><%= aa.getAddress() %></td>
                            <td><%= aa.getNumber() %></td>
                            <td><%= aa.getPrice() %>元</td>
                            <td><input type="button" class="indentbtn" value="未发货"></td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="list-page">总计<%= mnum %> 条</div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
