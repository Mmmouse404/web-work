<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.Orderlist" %>
<%@ page import="dao.Orderlist_Use" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>小卖部主页面</title>
    <link href="css/main.css" rel="stylesheet">
<%--    <script src="js/jquery-3.4.1.min.js"></script>--%>
<%--    <script src="js/ajax.js"></script>--%>
<%--    <script>--%>
<%--        $(function () {--%>
<%--            $("table tr td img").click(function () {--%>
<%--                var sname3=$(this).val();--%>
<%--                alert("123"+sname3);--%>
<%--                // params="sname3="+sname3;--%>
<%--                // sendRequest("MouseShop.jsp",params,"POST",succ);--%>
<%--            })--%>
<%--        })--%>

<%--        function succ() {}--%>

<%--    </script>--%>
</head>
<body>
<%--小卖部顶部页面--%>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png"></div>
    <div class="top_up">欢迎您：<%=session.getAttribute("upname")%>
        <img src="img/grzx.png" width="50" height="50">
        <a href="cart.jsp"><img src="img/gwc.png" width="50" height="50"></a>
    <a href="allShop.jsp"> <img src="img/allshop.png" width="75" height="50"></a>
    </div>
</div>

<%--商品列表展示--%>
    <div class="main_down">
        <h1 class="tit1">店长推荐:</h1>


    <div class="shop_table">
    <table>
        <%
            ArrayList<Orderlist> arr= Orderlist_Use.getOrderList();
            for(int i=0;i<=1;i++){
        %>

        <tr>
            <td><a href="<%="MouseShop.jsp?Sid="+arr.get(5*i).getId()%>"> <img src="<%=arr.get(5*i).getImage()%>" value="<%=arr.get(5*i).getGoodName()%>"></a></td>
            <td><a href="<%="MouseShop.jsp?Sid="+arr.get(5*i+1).getId()%>"><img src="<%=arr.get(5*i+1).getImage()%>" value="<%=arr.get(5*i+1).getGoodName()%>"></a></td>
            <td><a href="<%="MouseShop.jsp?Sid="+arr.get(5*i+2).getId()%>"><img src="<%=arr.get(5*i+2).getImage()%>" value="<%=arr.get(5*i+2).getGoodName()%>"></a></td>
            <td><a href="<%="MouseShop.jsp?Sid="+arr.get(5*i+3).getId()%>"><img src="<%=arr.get(5*i+3).getImage()%>" value="<%=arr.get(5*i+3).getGoodName()%>"></a></td>
            <td><a href="<%="MouseShop.jsp?Sid="+arr.get(5*i+4).getId()%>"><img src="<%=arr.get(5*i+4).getImage()%>" value="<%=arr.get(5*i+4).getGoodName()%>"></a></td>
        </tr>
        <tr>
            <td><span class="s1"><%=arr.get(5*i).getGoodName()%></span></td>
            <td><span class="s1"><%=arr.get(5*i+1).getGoodName()%></span></td>
            <td><span class="s1"><%=arr.get(5*i+2).getGoodName()%></span></td>
            <td><span class="s1"><%=arr.get(5*i+3).getGoodName()%></span></td>
            <td><span class="s1"><%=arr.get(5*i+4).getGoodName()%></span></td>
        </tr>
        <tr>
            <td><span class="s2">￥<%=arr.get(5*i).getPrice()%></span></td>
            <td><span class="s2">￥<%=arr.get(5*i+1).getPrice()%></span></td>
            <td><span class="s2">￥<%=arr.get(5*i+2).getPrice()%></span></td>
            <td><span class="s2">￥<%=arr.get(5*i+3).getPrice()%></span></td>
            <td><span class="s2">￥<%=arr.get(5*i+4).getPrice()%></span></td>
        </tr>
        <%}%>
    </table>
    </div>
    </div>
</body>
</html>