<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="sidebar-wrap">
    <div class="sidebar-title">
        <a href="#"><h1>菜单</h1></a>
    </div>
    <div class="sidebar-content">
        <ul class="sidebar-list">
            <li>
                <a href="#">用户管理</a>
                <ul class="sub-menu">
                    <li><a href="manageUser.jsp">用户信息（管理员）</a></li>
                    <li><a href="manageUserOrder.jsp">用户订单日志</a></li>
                </ul>
            </li>
            <li>
                <a href="#">商品管理</a>
                <ul class="sub-menu">
                    <li><a href="manageGood.jsp">全部商品</a></li>
                    <li><a href="insertGood.jsp">添加商品</a></li>
                    <li><a href="editGood.jsp">修改商品</a></li>
                    <li><a href="manageGood.jsp">删除商品</a></li>
                    <li><a href="manageOrder.jsp">商品订单</a></li>
                </ul>
            </li>

        </ul>
    </div>
</div>
