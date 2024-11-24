<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全部商品后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            // 全选框的实现
            $("#c1").click(function () {
                $("input[name='checkbox']").attr("checked", this.checked);
            });
            // 下拉菜单栏的实现 toggle():切换隐藏显示状态
            $(".sidebar-content > ul > li").click(function () {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content > ul").toggle();
            });
        });

        function batchDelete() {
            var selectedIds = [];
            $("input[name='checkbox']:checked").each(function () {
                selectedIds.push($(this).val()); // 获取选中复选框的值，即商品编号
            });

            if (selectedIds.length === 0) {
                alert("请至少选择一个商品进行删除！");
                return;
            }

            if (confirm("确认要删除所选商品吗？")) {
                // 发送AJAX请求
                $.ajax({
                    url: "batchDelete", // 删除处理的服务器端URL
                    type: "POST",
                    data: { ids: selectedIds }, // 发送商品编号数组
                    traditional: true, // 处理数组
                    success: function(response) {
                        alert("商品删除成功！"); // 提示用户商品已删除
                        location.reload(); // 刷新当前页面
                    },
                    error: function(xhr, status, error) {
                        alert("删除失败，请重试。"); // 错误提示
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="topbar-wrap white">
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix">
            <h1 class="topbar-logo none"><a href="manageUser.jsp" class="navbar-brand">后台管理</a></h1>
            <ul class="navbar-list clearfix">
                <li><a class="on" href="manageUser.jsp">首页</a></li>
                <li><a href="user.jsp" target="_blank">小卖部用户登录</a></li>
            </ul>
        </div>
        <div class="top-info-wrap">
            <ul class="top-info-list clearfix">
                <li><a href="#">管理员</a></li>
                <li><a href="#">店长信息</a></li>
                <li><a href="#">退出</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="container clearfix">
    <div class="sidebar-wrap">
        <div class="sidebar-title">
            <a href="#"><h1>菜单</h1></a>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-list">
                <li>
                    <a href="#">用户管理</a>
                    <ul class="sub-menu">
                        <li><a href="manageUser.jsp">用户信息</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">商品管理</a>
                    <ul class="sub-menu">
                        <li><a href="#">全部商品</a></li>
                        <li><a href="insertGood.jsp">添加商品</a></li>
                        <li><a href="manageGood.jsp">删除商品</a></li>
                        <li><a href="manageOrder.jsp">商品订单</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="icon-font">&#xe018;</i>系统管理</a>
                    <ul class="sub-menu">
                        <li><a href="manageSetting.jsp">系统设置</a></li>
                        <li><a href="manageSetting.jsp">清理缓存</a></li>
                        <li><a href="manageSetting.jsp">数据备份</a></li>
                        <li><a href="manageSetting.jsp">数据还原</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><a href="manageUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">商品管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="manageGood.jsp" method="get"> <!-- 修改为GET请求 -->
                    <table class="search-tab">
                        <tr>
                            <th width="120">选择分类:</th>
                            <td>
                                <select name="search-sort">
                                    <option value="">全部</option>
                                    <%
                                        ArrayList<String> kinds = Goodlist_Use.getAllKinds(); // 从数据库获取所有分类
                                        for (String kind : kinds) {
                                    %>
                                    <option value="<%= kind %>" <%= request.getParameter("search-sort") != null && request.getParameter("search-sort").equals(kind) ? "selected" : "" %>><%= kind %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <th width="70">关键字:</th>
                            <td><input class="common-text" placeholder="关键字" name="keywords" value="<%= request.getParameter("keywords") != null ? request.getParameter("keywords") : "" %>" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="insertGood.jsp">新增商品</a>
                        <a id="batchDel" href="#" onclick="batchDelete();">批量删除</a>
                        <a id="updateOrd" href="#">更新排序</a>
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
                            String searchSort = request.getParameter("search-sort");
                            String keywords = request.getParameter("keywords");
                            ArrayList<Goodlist> RR = Goodlist_Use.getGoodList(searchSort, keywords); // 根据条件获取商品列表
                            int num = RR.size(); // 商品数量
                            for (Goodlist a : RR) {
                        %>
                        <tr>
                            <td class="tc"><input name="checkbox" value="<%= a.getId() %>" type="checkbox"></td>
                            <td><img src="<%= a.getImage() %>" style="width: 100px; height: 100px; object-fit: cover;"></td> <!-- 固定大小 -->
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
    <!--/main-->
</div>
</body>
</html>