<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="topbar-wrap">
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix">
            <h1 class="topbar-logo none">
                <a href="manageUser.jsp" class="navbar-brand">后台管理</a>
            </h1>
            <ul class="navbar-list clearfix">
                <li><a class="on" href="manageUser.jsp">首页</a></li>

            </ul>
        </div>
        <div class="top-info-wrap">
            <ul class="top-info-list clearfix">
                <li><a class="on" href="manageUser.jsp">管理员</a></li>
                <li><a class="on" href="login.jsp" >用户登录</a></li>
                <li><a class="on" href="logout">退出</a></li> <!-- 修改为直接链接到 logoutServlet -->
            </ul>
        </div>
    </div>
</div>
