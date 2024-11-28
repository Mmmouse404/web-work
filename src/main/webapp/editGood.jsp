<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="java.sql.SQLException" %>
<html>
<head>
    <title>小卖部后台管理修改商品</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/manage.css" />
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
            });
        });
        function updateGood(id) {
            var formData = new FormData();
            var goodImage = document.getElementById('image_' + id).files[0];
            var goodKind = $("#kind_" + id).val();
            var goodName = $("#name_" + id).val();
            var goodPrice = $("#price_" + id).val();
            var goodStock = $("#stock_" + id).val();
            var merchantName = "<%= session.getAttribute("merchantname") %>";

            formData.append("image", goodImage);
            formData.append("kind", goodKind);
            formData.append("goodname", goodName);
            formData.append("price", goodPrice);
            formData.append("stock", goodStock);
            formData.append("merchantname", merchantName);
            formData.append("id", id); // 添加商品ID以进行更新

            $.ajax({
                url: "updateGood", // 定义Servlet的处理路径
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert("商品修改成功！" + response);
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert("修改失败，请重试：" + error);
                }
            });
        }

        function previewImage(event, id) {
            var imagePreview = document.getElementById('imagePreview_' + id);
            var file = event.target.files[0];

            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                imagePreview.src = "";
                imagePreview.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container clearfix">
    <jsp:include page="sidebar.jsp" />
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><a href="manageUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">修改商品</span></div>
        </div>
        <div class="result-wrap">
            <div class="config-items">
                <div class="config-title">
                    <h1><i class="icon-font">&#xe00a;</i>小卖部修改商品</h1>
                </div>
                <div class="result-content">
                    <table width="100%" class="insert-tab">
                        <thead>
                        <tr>
                            <th>商品编号</th>
                            <th>商品名称</th>
                            <th>商品类别</th>
                            <th>商品价格</th>
                            <th>商品库存</th>
                            <th>商家名称</th>
                            <th>选择图片</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            ArrayList<Goodlist> goods = null; // 获取所有商品
                            try {
                                goods = Goodlist_Use.getGoodList();
                            } catch (SQLException e) {
                                throw new RuntimeException(e);
                            }
                            for (Goodlist good : goods) {
                        %>
                        <tr>
                            <td><%= good.getId() %></td>
                            <td><input type="text" id="name_<%= good.getId() %>" value="<%= good.getGoodName() %>" class="common-text" /></td>
                            <td><input type="text" id="kind_<%= good.getId() %>" value="<%= good.getKind() %>" class="common-text" /></td>
                            <td><input type="text" id="price_<%= good.getId() %>" value="<%= good.getPrice() %>" class="common-text" /></td>
                            <td><input type="text" id="stock_<%= good.getId() %>" value="<%= good.getStock() %>" class="common-text" /></td>
                            <td><input type="text" value="<%= good.getMerchantName() %>" class="common-text" readonly /></td>
                            <td>
                                <input type="file" id="image_<%= good.getId() %>" class="common-text" accept="image/*" onchange="previewImage(event, '<%= good.getId() %>')">
                                <br>
                                <img id="imagePreview_<%= good.getId() %>" src="<%= good.getImage() %>" alt="图片预览" style="max-width:200px; max-height:200px; margin-top:10px;">
                            </td>
                            <td>
                                <input type="button" value="修改" class="btn btn-primary btn6 mr10" onclick="updateGood('<%= good.getId() %>');">
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
