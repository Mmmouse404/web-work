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
                        <a id="batchDel" href="#">批量删除</a>
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
                            ArrayList<Order> RR = Order_Use.getOrders();
                            int mnum = Order_Use.getGoodNumber();
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
