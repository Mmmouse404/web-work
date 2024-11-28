<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 检查用户是否已登录
    if (session.getAttribute("merchantname") == null) {
        response.sendRedirect("login.jsp"); // 如果未登录，重定向到登录页面
        return; // 结束当前页面的执行
    }
%>
<html>
<head>
    <title>全部商品后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script >
        function batchDelete() {
            var ids = [];
            // 获取所有选中的复选框
            $("input[name='checkbox']:checked").each(function() {
                ids.push($(this).val()); // 将选中的商品 ID 添加到数组
            });

            if (ids.length === 0) {
                alert("请至少选择一件商品进行删除！");
                return; // 如果没有选中商品，结束函数
            }

            // 发送 AJAX 请求到后端进行删除
            $.ajax({
                url: "goodBatchDelete",
                type: "POST",
                data: { ids: ids }, // 注意数据格式
                traditional: true, // 使得数组以传统方式传递
                success: function(response) {
                    {
                        alert("商品已成功删除");
                        window.location.reload(); // 刷新页面
                    }
                },
                error: function() {
                    alert("请求失败，请重试");
                }
            });
        }

        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
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
            <div class="crumb-list"><a href="manageUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">商品管理</span></div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="insertGood.jsp">新增商品</a>
                        <a href="editGood.jsp">修改商品</a>
                        <a id="batchDel" href="#" onclick="batchDelete();">批量删除</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" name="" type="checkbox" id="c1">全选</th>
                            <th>商品图片</th>
                            <th>商品编号</th>
                            <th>商品类别</th>
                            <th>商品名称</th>
                            <th>商品价格</th>
                            <th>商品库存</th>
                            <th>商家名称</th>
                        </tr>
                        <%
                            String merchantName = (String) session.getAttribute("merchantname"); // 获取当前商家的名称
                            ArrayList<Goodlist> RR = Goodlist_Use.getGoodsByMerchantName(merchantName); // 只获取该商家的商品列表
                            int num = RR.size();
                            for (Goodlist a : RR) {
                        %>
                        <tr>
                            <td class="tc"><input name="checkbox" value="<%= a.getId() %>" type="checkbox"></td>
                            <td><img src="<%= a.getImage() %>" style="width: 100px; height: 100px; object-fit: cover;"></td>
                            <td><%= a.getId() %></td>
                            <td><%= a.getKind() %></td>
                            <td><%= a.getGoodName() %></td>
                            <td><%= a.getPrice() %>元</td>
                            <td><%= a.getStock() %></td>
                            <td><%= a.getMerchantName() %></td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="list-page">总计<%= num %> 条</div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
