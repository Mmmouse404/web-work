<%--
  Created by IntelliJ IDEA.
  User: DSHH
  Date: 2021/10/11
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录失败</title>
</head>
<body>
<p align="center"><b><font size="+5" color="red"> <%=session.getAttribute("upname")%>  登录失败!</font>
    <br><br><font size="+2">正在返回登录页面......</font>
</b></p>
<%session.setAttribute("upname",null);%>
<%response.setHeader("refresh","1;http://8.134.196.79:8080/javaweb_mouse_war_exploded/login.jsp");  //3秒后，重定向登录页面%>
<div style="position:absolute;left: 20%;top: 30%"> <img src="img/伤心.jpg" width="185" height="211" /></div>
<div style="position:absolute;left: 70%;top: 30%"> <img src="img/伤心.jpg" width="185" height="211"/></div>
</body>
</html>