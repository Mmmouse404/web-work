<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>全部商品</title>
    <link rel="stylesheet" href="css/allShop.css">
</head>
<body>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png"></div>
    <div class="top_up">
        欢迎您：<c:out value="${sessionScope.upname}"/>
        <img src="img/grzx.png" width="50" height="50">
        <a href="cart.jsp"><img src="img/gwc.png" width="50" height="50"></a>
        <a href="mainFrame.jsp"><img src="img/dztj.jpg" width="50" height="50"></a>
    </div>
</div>

<div class="main_down">
    <table class="qtable">
        <c:set var="shopList" value="${Shoplist_use.getShopList()}" />
        <c:forEach items="${shopList}" var="a">
            <tr>
                <td class="center"><c:out value="${a.kind}" /></td>
                <td class="center"><img src="<c:out value="${a.image}" />" /></td>
                <td class="center"><c:out value="${a.name}" /></td>
                <td class="center"><c:out value="${a.price}" />元</td>
                <td class="center">
                    <a href="mouseShop.jsp?Sid=${a.id}">
                        <input type="button" value="购买" id="qbtn" />
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
