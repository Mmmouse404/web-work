<%@ page contentType="text/html;charset=UTF-8" language="java" %><%@ page import="java.util.*" %><%@ page import="dao.Cart_Use" %><%@ page import="dao.Cart" %><%@ page import="java.sql.SQLException" %><%    // 检查用户是否已登录    if (session.getAttribute("upname") == null) {        response.sendRedirect("login.jsp"); // 如果未登录，重定向到登录页面        return; // 结束当前页面的执行    }%><html><head>    <title>购物车界面</title>    <link href="css/main.css" rel="stylesheet">    <link href="css/Gwc.css" rel="stylesheet">    <script src="js/jquery-3.4.1.min.js"></script>    <script>        function deleteItem(itemId) {            $.post("cartAction", { action: "delete", id: itemId }, function(response) {                if (response === "success") {                    alert("商品已删除");                    window.location.reload(); // 刷新当前页面                } else {                    alert("删除失败，请重试");                }            });        }        function clearCart() {            if (confirm("您确定要清空购物车吗？")) {                $.post("cartAction", { action: "clear" }, function(response) {                    if (response === "success") {                        alert("购物车已清空");                        window.location.reload(); // 刷新当前页面                    } else {                        alert("清空购物车失败，请重试");                    }                });            }        }        function checkout() {            let selectedItems = [];            let username = "<%=session.getAttribute("upname")%>"; // 获取用户名            let selectedItemsHtml = "<h3>已选择的商品：</h3><ul>"; // 初始化 HTML 代码            $('.check_one:checked').each(function() {                let row = $(this).closest('tr');                let goodname = row.find('td:eq(1)').text(); // 商品名称                let number = row.find('.goods_num').val(); // 商品数量                let price = row.find('.goods_price').text(); // 商品单价                let address = row.find('input.address').val(); // 获取地址                let merchantname = row.find('.merchant_name').text(); // 获取商家名称                selectedItems.push({                    username: username,                    goodname: goodname,                    number: number,                    price: price,                    address: address,                    merchantname: merchantname // 包含商家名称                });                // 将已选择的商品信息添加到 HTML 中                selectedItemsHtml += "<li>" + goodname + " - 数量: " + number + " - 单价: " + price + " - 商家: " + merchantname + "</li>";            });            selectedItemsHtml += "</ul>"; // 结束列表            // 更新显示已选商品的 DIV            $('#selectedItems').html(selectedItemsHtml);            if (selectedItems.length === 0) {                alert("请至少选择一件商品进行结算！");                return;            }            // 将选中的商品信息传递到下单Servlet            $.ajax({                url: "iindent",                type: "POST",                data: { items: JSON.stringify(selectedItems) },                success: function(response) {                    alert("订单创建成功！");                    window.location.reload(); // 刷新页面                },                error: function() {                    alert("订单创建失败，请重试");                }            });        }    </script></head><body><div class="main_head">    <div class="logo"><img src="img/logo2.png"></div>    <div class="top_up">欢迎您：<%=session.getAttribute("upname")%>        <a href="cart.jsp">购物车</a>        <a href="allShop.jsp">全部商品</a>        <a href="logout">退出</a>        <a href="login.jsp" class="login-button">登录</a>    </div></div><div class="main_down">    <div class="container">        <div class="cart_top"><span>购物车</span></div>        <div class="cart_wrap">            <table class="cart_table" border="1" cellspacing="0" bgcolor="#fffafa" rules="rows">                <tr class="cart_title">                    <th></th>                    <th>商品</th>                    <th>单价</th>                    <th>数量</th>                    <th>总价</th>                    <th>地址</th>                    <th>商家名称</th>                    <th>操作</th>                </tr>                <%                    String username = (String) session.getAttribute("upname");                    ArrayList<Cart> cartItems = Cart_Use.getCartItems(username);                    for (Cart item : cartItems) {                %>                <tr class="cart_item">                    <td><input type="checkbox" class="check_one">&nbsp;</td>                    <td class="goods_name"><%=item.getGoodName()%></td>                    <td class="goods_price"><%=item.getPrice()%></td>                    <td>                        <input type="text" value="<%=item.getNumber()%>" class="goods_num">                    </td>                    <td><%=String.format("%.2f", item.getNumber() * Double.parseDouble(item.getPrice()))%></td>                    <td><input type="text" class="address" value="<%=item.getAddress()%>" placeholder="填写地址"></td>                    <td class="merchant_name"><%=item.getmerchantname()%></td>                    <td>                        <button onclick="deleteItem('<%=item.getId()%>')">删除</button>                    </td>                </tr>                <%                    }                %>            </table>            <button onclick="clearCart()">清空购物车</button>            <button onclick="checkout()">结算</button>        </div>        <div id="selectedItems" style="margin-top:20px; border: 1px solid #ccc; padding: 10px;">            <!-- 用于显示选中的商品信息 -->        </div>    </div></div></body></html>