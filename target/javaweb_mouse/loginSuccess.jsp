<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成功</title>
</head>
<body>
<p align="center"><b><font size="+5" color="red">
    <%
        String userType = (String) session.getAttribute("userType");
        String username = "";

        if ("merchant".equals(userType)) {
            username = (String) session.getAttribute("merchantName"); // 获取商家名称
            out.print("商家: " + username);
        } else {
            username = (String) session.getAttribute("upname"); // 获取用户名称
            out.print("用户: " + username);
        }
    %>
    登录成功!</font>
    <br><br><font size="+2">正在进入......</font>
</b></p>

<%
    String redirectPage = userType.equals("merchant") ? "manageGood.jsp" : "mainFrame.jsp";
    response.setHeader("refresh", "1;http://localhost:8080/javaweb_mouse_war_exploded/" + redirectPage);
%>
<div style="position:absolute;left: 20%;top: 30%"> <img src="img/kx2.jpg" width="185" height="211" /></div>
<div style="position:absolute;left: 70%;top: 30%"> <img src="img/kx2.jpg" width="185" height="211"/></div>
</body>
</html>
