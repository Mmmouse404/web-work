<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.User_Use" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Objects" %>
<jsp:include page="increaseMoney.jsp" />
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("upname"); // 获取用户名
    double userMoney = 0.0; // 存储用户余额

    // 如果用户已登录，获取用户的金额
    if (username != null) {
        try {
            userMoney = User_Use.getUserMoney(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    // 搜索功能
    String searchSort = request.getParameter("search-sort");
    String keywords = request.getParameter("keywords");
%>
<html>
<head>
    <title>商品详情</title>
    <style>
        body {
            background: url("img/bg3.jpg") repeat;
        }
    </style>
    <link href="css/main.css" rel="stylesheet">
    <link href="css/Shop_cat.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/ajax.js"></script>
    <script>
        $(function () {
            function calc() {
                var price = parseFloat($("#goods_price").text()); // 获取单价
                var quantity = parseInt($("#number").val()); // 获取数量
                var stock = parseInt($("#stock").text()); // 获取库存
                var total = (price * quantity).toFixed(2); // 计算总价
                $("#good_total").text(total); // 显示总价

                // 限制数量不能超过库存
                if (quantity > stock) {
                    quantity = stock; // 如果超过库存，将数量设置为库存
                    $("#number").val(quantity); // 更新输入框
                    alert("已达到库存上限，最多只能购买 " + stock + " 件。");
                }
                // 更新加号按钮的状态
                updateAddButtonState(quantity, stock);
            }
            // 更新加号按钮的状态
            function updateAddButtonState(quantity, stock) {
                if (quantity >= stock) {
                    $("#i2").addClass("unavailable"); // 添加变暗样式
                } else {
                    $("#i2").removeClass("unavailable"); // 移除样式
                }
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
                var stock = parseInt($("#stock").text()); // 获取库存
                num++; // 自增
                // 限制数量不能超过库存
                if (num > stock) {
                    num = stock; // 如果超过库存，将数量设置为库存
                    alert("已达到库存上限，最多只能购买 " + stock + " 件。");
                }
                $("#number").val(num);
                calc(); // 重新计算总价
            });

            // 手动输入数量计算
            $('#number').on('input', function () {
                calc(); // 每次输入后重新计算总价
            });
        });

        function showIncreaseMoneyDialog() {
            document.getElementById("increaseMoneyDialog").style.display = "block"; // 显示弹出框
        }

        function addToCart() {
            var goodname = $("#tt").text(); // 商品名称
            var username = "<%=session.getAttribute("upname")%>"; // 用户名称
            var address = $("#dz").val(); // 用户填写的地址
            var number = $("#number").val(); // 商品数量
            var price = $("#good_total").text(); // 商品总价
            var merchantName = $("#merchantname").text(); // 商家名称
            var goodId =  $("#good_id").text(); // 商品ID
            var description = $("#description").text(); // 商品描述
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
                + "&merchantname=" + encodeURIComponent(merchantName) // 注意大小写
                + "&goodId=" + encodeURIComponent(goodId)
                + "&description=" + encodeURIComponent(description);
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
            var goodId =  $("#good_id").text(); // 商品ID
            var description = $("#description").text(); // 商品描述
            var param = "goodname=" + encodeURIComponent(goodname)
                + "&username=" + encodeURIComponent(username)
                + "&number=" + encodeURIComponent(number)
                + "&address=" + encodeURIComponent(address)
                + "&price=" + encodeURIComponent(price)
                + "&merchantname=" + encodeURIComponent(merchantname)
                + "&goodId=" + encodeURIComponent(goodId);
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
<div class="main_head" style="display: flex; align-items: center; justify-content: flex-start;">
    <div class="logo" style="position: absolute;width: 50px;height: 50px;"><img src="img/mouse.png"></div>
    <!-- 搜索表单 -->
    <div class="search-wrap" style="left: 20%;top: 8%; position: absolute;">
        <form action="allShop.jsp" method="get"> <!-- 提交查询 -->
            <label>选择分类:</label>
            <select name="search-sort">
                <option value="">全部</option>
                <%
                    ArrayList<String> kinds = Goodlist_Use.getAllKinds(); // 从数据库获取所有分类
                    for (String kind : kinds) {
                %>
                <option value="<%= kind %>" <%= searchSort != null && searchSort.equals(kind) ? "selected" : "" %>><%= kind %></option>
                <%
                    }
                %>
            </select>

            <label >关键字:</label>
            <input type="text" name="keywords" placeholder="输入关键字" value="<%= keywords != null ? keywords : "" %>">
            <input type="submit" value="查询">
        </form>
    </div>
    <div class="top_up" style="top: 99%; position: absolute;">欢迎您：<%= username != null ? username : "游客" %>
        <% if (username != null) { %>
        | 账户余额：<%= userMoney %>元
        <input type="button" value="增加金额" id="increaseMoneyBtn" onclick="showIncreaseMoneyDialog()"/> <!-- 调用函数显示对话框 -->

        <% } %>
    </div>

    <div class="navigation">
        <a href="userProfile.jsp">个人中心</a>
        <a href="mainFrame.jsp">推荐商品</a>
        <a href="allShop.jsp">全部商品</a>
        <a href="cart.jsp">购物车</a>
        <a href="myOrders.jsp">订单</a>
        <% if (username != null) { %>
        <a href="logout">退出</a> <!-- 退出登录链接 -->
        <% } else { %>
        <a href="login.jsp">登录</a> <!-- 登录链接 -->
        <% } %>
        <a href="manageGood.jsp" class="login-button">商家</a> <!-- 新增登录按钮 -->
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
            <img src="<%=item.getImage()%>" alt="商品图片"> <!-- 增大图片 -->
        </div>
        <div class="mas_table">
            <table align="left">
                <tr>
                    <td>
                        <div class="shopname">
                            <h1 id="tt"><%=item.getGoodName()%></h1>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="padding: 0;">
                        <div class="info-container">
                            <div class="info-item">商家名称：<i id="merchantname"><%=item.getMerchantName()%></i></div>
                            <div class="info-item">商家编号：<i id="good_id"><%=item.getId()%></i></div>
                            <div class="info-item">单价：<i class="goods_price" id="goods_price"><%=item.getPrice()%></i>元</div>
                            <div class="info-item">库存：<span id="stock"><%=item.getStock()%></span>件</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="product-info">
                            商品描述：
                            <p id="description" style="display: inline-block; ">
                                <%=!Objects.equals(item.getDescription(), "null") ? item.getDescription() : "这个商家很懒，什么都没有留下" %>
                            </p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="goods_num_wrap">
                            购买数量：<span id="i1" style="text-align: center;">-</span>
                            <input type="text" value="1" class="goods_num" id="number">
                            <span id="i2" style="text-align: center;">+</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>总价：<i class="good_total" id="good_total"><%=item.getPrice()%></i>元</td>
                </tr>
                <tr>
                    <td>
                        <div class="address-info">
                            地址：<input type="text" placeholder="请填写地址，例：6#505" id="dz">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="button-container">
                            <input type="button" value="加入购物车"  class="add-cart-button" onclick="addToCart()" /> <!-- 添加到购物车 -->
                            <input type="button" value="返回"  class="add-cart-button" onclick="history.back()" /> <!-- 返回按钮 -->
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
