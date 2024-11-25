<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<html>
<head>
    <title>商品详情</title>
    <link href="css/main.css" rel="stylesheet">
    <link href="css/Shop_cat.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/ajax.js"></script>
    <script>
        $(function () {
            function calc() {
                var price = parseFloat($("#goods_price").text()); // 获取单价
                var quantity = parseInt($("#number").val()); // 获取数量
                var total = (price * quantity).toFixed(2); // 计算总价
                $("#good_total").text(total); // 显示总价
            }

            // 商品数量加减
            $("#i1").click(function () {
                var num = parseInt($("#number").val());
                num = (num > 1) ? num - 1 : 1; // 确保最小为1
                $("#number").val(num);
                calc(); // 重新计算总价
            });
            $("#i2").click(function () {
                var num = parseInt($("#number").val());
                num++; // 自增
                $("#number").val(num);
                calc(); // 重新计算总价
            });

            // 手动输入数量计算
            $('#number').on('input', function () {
                calc(); // 每次输入后重新计算总价
            });
        });

        function addToCart() {
            var goodname = $("#tt").text(); // 商品名称
            var username = "<%=session.getAttribute("upname")%>"; // 用户名称
            var address = $("#dz").val(); // 用户填写的地址
            var number = $("#number").val(); // 商品数量
            var price = $("#good_total").text(); // 商品总价
            var merchantName = $("#merchantname").text(); // 商家名称

            // 验证输入信息是否合法
            if (!goodname || !username || !address || !number || !price || !merchantName) {
                alert("请确保所有信息都填写正确！");
                return;
            }

            var param = "goodname=" + encodeURIComponent(goodname)
                + "&username=" + encodeURIComponent(username)
                + "&address=" + encodeURIComponent(address)
                + "&number=" + encodeURIComponent(number)
                + "&price=" + encodeURIComponent(price)
                + "&merchantname=" + encodeURIComponent(merchantName); // 注意大小写

            // 发送请求到 addToCart Servlet
            $.ajax({
                url: "addToCart", // 后端处理的 URL
                type: "POST",
                data: param,
                success: function(response) {
                    console.log("服务器响应:", response); // 添加日志
                    if (response.trim() === "success") { // 使用 trim() 去除首尾空格
                        alert("成功加入购物车！");
                    } else {
                        alert( response); // 显示错误内容
                    }
                },
                error: function() {
                    alert("请求失败，请重试。");
                }
            });
        }

        function insertindent() {
            var goodname = $("#tt").text(); // 商品名称
            var username = "<%=session.getAttribute("upname")%>"; // 当前用户名称
            var address = $("#dz").val(); // 用户填写的地址
            var number = $("#number").val(); // 购买数量
            var price = $("#good_total").text(); // 总价
            var merchantname = "<%=session.getAttribute("merchantname")%>"; // 商家名称

            var param = "goodname=" + encodeURIComponent(goodname)
                + "&username=" + encodeURIComponent(username)
                + "&number=" + encodeURIComponent(number)
                + "&address=" + encodeURIComponent(address)
                + "&price=" + encodeURIComponent(price)
                + "&merchantname=" + encodeURIComponent(merchantname);

            sendRequest("iindent", param, "POST", result);
        }

        function result() {
            if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) {
                    alert("购买成功！店长正在抓紧发货~");
                } else {
                    alert("购买失败，请重试。");
                }
            }
        }
    </script>
</head>
<body>
<%-- 小卖部顶部页面 --%>
<div class="main_head">
    <div class="logo"><img src="img/logo3.png"></div>
    <div class="top_up">欢迎您：<%=session.getAttribute("upname")%>
        <img src="img/grzx.png" width="50" height="50">
        <a href="cart.jsp"><img src="img/gwc.png" width="50" height="50"></a>
        <a href="allShop.jsp"><img src="img/allshop.png" width="75" height="50"></a>
    </div>
</div>

<%
    String id = request.getParameter("Sid"); // 获取要显示商品的ID
    Goodlist item = null;
    try {
        item = Goodlist_Use.searchGoodById(id); // 根据ID查询商品信息
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (item == null) {
        out.println("<h2>商品未找到</h2>");
        return;
    }
%>
<%-- 商品详情展示 --%>
<div class="main_down">
    <div class="mainwdow">
        <div class="picture">
            <img src="<%=item.getImage()%>" width="400" height="400">
        </div>
        <div class="mas_table">
            <table align="left">
                <tr>
                    <td>
                        <div class="shopname">
                            <h1 id="tt"><%=item.getGoodName()%></h1>
                        </div>
                    </td>
                    <td>商家名称：<h2 id="merchantname"><%=item.getMerchantName()%></h2> <!-- 显示商家名称 --></td>
                </tr>
                <tr>
                    <td>单价：<i class="goods_price" id="goods_price"><%=item.getPrice()%></i>元</td>
                </tr>
                <tr>
                    <td>
                        <div class="goods_num_wrap">
                            <span id="i1">-</span><input type="text" value="1" class="goods_num" id="number"><span id="i2">+</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>总价：<i class="good_total" id="good_total">--</i>元</td>
                </tr>
                <tr>
                    <td>
                        <div class="cataddress">
                            <input type="text" placeholder="请填写地址，例：6#505" id="dz">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="购买" id="gbtn" onclick="insertindent()">
                        <input type="button" value="加入购物车" id="jgwc" onclick="addToCart()"> <!-- 添加到购物车 -->
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
