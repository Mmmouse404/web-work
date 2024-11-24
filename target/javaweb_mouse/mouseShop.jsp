<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="dao.Order" %>
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
            calc();
            function calc() {
                // 计算商品总价 单价*数量（保留两位小数）
                $('.good_total').map((i, k) => {
                    $(k).text(($(".goods_num").val() * $(".goods_price").text()).toFixed(2));
                });
            }

            $('.goods_num_wrap').map((i, k) => {
                // 数量减
                $(k).find('span').eq(0).click(function () {
                    var num = $(this).next().val();
                    num--;
                    num = num < 1 ? 1 : num;
                    $(this).next().val(num);
                    calc();
                });
                // 数量加
                $(k).find('span').eq(1).click(function () {
                    var num2 = $(this).prev().val();
                    num2++;
                    num2 = num2 > 999 ? 999 : num2;
                    $(this).prev().val(num2);
                    calc();
                });
                // 手动输入
                $(k).find('.goods_num').blur(function () {
                    var num3 = $(k).find('.goods_num').val();
                    num3 = num3 > 999 ? 999 : (num3 < 1 ? 1 : num3);
                    $(k).find('.goods_num').val(num3);
                    calc();
                });
            });

            // 添加购物车
            $('#jgwc').click(function() {
                addToCart();
            });
        });

        function addToCart() {
            var goodname = $("#tt").text(); // 商品名称
            var username = "<%=session.getAttribute("upname")%>"; // 用户名称
            var address = $("#dz").val(); // 用户填写的地址
            var number = $("#number").val(); // 商品数量
            var price = $(".good_total").text(); // 商品总价
            var merchantName = "<%=session.getAttribute("merchantname")%>"; // 商家名称

            var param = "goodname=" + encodeURIComponent(goodname)
                + "&username=" + encodeURIComponent(username)
                + "&address=" + encodeURIComponent(address)
                + "&number=" + encodeURIComponent(number)
                + "&price=" + encodeURIComponent(price)
                + "&merchantName=" + encodeURIComponent(merchantName);

            sendRequest("addToCart", param, "POST", cartResult);
        }

        function cartResult() {
            if (httpRequest.readyState == 4 && httpRequest.status == 200) {
                alert("成功加入购物车！");
            } else {
                alert("加入购物车失败，请重试。");
            }
        }

        function insertindent() {
            var i1 = $("#tt").text(); // 商品名称
            var i2 = "<%=session.getAttribute("upname")%>"; // 当前用户名称
            var i3 = $("#number").val(); // 购买数量
            var i4 = $("#dz").val(); // 用户填写的地址
            var i5 = $(".good_total").text(); // 总价
            var i6 = "<%=session.getAttribute("merchantname")%>"; // 商家名称

            var param = "goodname=" + encodeURIComponent(i1)
                + "&username=" + encodeURIComponent(i2)
                + "&number=" + encodeURIComponent(i3)
                + "&address=" + encodeURIComponent(i4)
                + "&price=" + encodeURIComponent(i5)
                + "&merchantName=" + encodeURIComponent(i6);

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
        <a href="mainFrame.jsp"><img src="img/dztj.jpg" width="50" height="50"></a>
        <a href="allShop.jsp"><img src="img/allshop.png" width="75" height="50"></a>
    </div>
</div>
<%
    String id = request.getParameter("Sid");   // 获取要显示商品的ID
    String name = Goodlist_Use.searchNameById(id);    // 根据ID查询名字
    String price = Goodlist_Use.searchPriceById(id);   // 根据ID查询价格
    String image = Goodlist_Use.searchImageById(id);  // 根据ID查询商品图片
%>
<%-- 商品详情展示 --%>
<div class="main_down">
    <div class="mainwdow">
        <div class="picture">
            <img src="<%=image%>" width="400" height="400">
        </div>
        <div class="mas_table">
            <table align="left">
                <tr>
                    <td>
                        <div class="shopname">
                            <h1 id="tt"><%=name%></h1>
                            <p>【送货上门】【过期包赔】【涨包无理由退换货】【包邮】</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>单价：<i class="goods_price"><%=price%></i>元</td>
                </tr>
                <tr>
                    <td>
                        <div class="goods_num_wrap">
                            <span>-</span><input type="text" value="1" class="goods_num" id="number"><span>+</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>总价：<i class="good_total">--</i>元</td>
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
                        <input type="button" value="加入购物车" id="jgwc">
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
