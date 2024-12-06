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

            // 搜索功能
            $("#searchGood").on("input", function() {
                filterGoods();
            });

            $("#searchSort").change(function() {
                filterGoods();
            });

            function filterGoods() {
                var searchText = $("#searchGood").val().toLowerCase();
                var selectedSort = $("#searchSort").val().toLowerCase();

                $(".good-row").each(function() {
                    var goodName = $(this).find("td:eq(1) input").val().toLowerCase();
                    var goodKind = $(this).find("td:eq(2) input").val().toLowerCase();

                    var nameMatch = goodName.includes(searchText);
                    var kindMatch = selectedSort === "" || goodKind === selectedSort;

                    if (nameMatch && kindMatch) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }
        });

        function updateGood(id) {
            var formData = new FormData();
            var goodImage = document.getElementById('image_' + id).files[0];
            var goodKind = $("#kind_" + id).val();
            var goodName = $("#name_" + id).val();
            var goodPrice = $("#price_" + id).val();
            var goodStock = $("#stock_" + id).val();
            var merchantName = "<%= session.getAttribute("merchantname") %>";
            var description = $("#description_" + id).val();
            formData.append("image", goodImage);
            formData.append("kind", goodKind);
            formData.append("goodname", goodName);
            formData.append("price", goodPrice);
            formData.append("stock", goodStock);
            formData.append("merchantname", merchantName);
            formData.append("id", id); // 添加商品ID以进行更新
            formData.append("description", description);
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
            <div class="crumb-list"><a href="manageGood.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">修改商品</span></div>
        </div>
        <div class="result-wrap">
            <div class="config-items">
                <div class="config-title">
                    <h1 style="display: inline-block; margin-right: 15px;"><i class="icon-font"></i>小卖部修改商品</h1>
                    <a href="manageGood.jsp" class="btn btn-primary">返回</a>
                    <div class="search-and-back">
                        <div class="search-content">
                            <table class="search-tab">
                                <tr>

                                    <th width="120">选择分类:</th>
                                    <td>
                                        <select id="searchSort">
                                            <option value="">全部</option>
                                            <%
                                                ArrayList<String> kinds = Goodlist_Use.getAllKinds(); // 从数据库获取所有分类
                                                for (String kind : kinds) {
                                            %>
                                            <option value="<%= kind %>"><%= kind %></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <th width="70">关键字:</th>
                                    <td><input class="common-text" id="searchGood" placeholder="搜索商品名称" type="text"></td>
                                </tr>
                            </table>

                        </div>

                    </div>
                </div>

                <div class="result-content">
                    <table width="100%" class="insert-tab">
                        <thead>
                        <tr>
                            <th style="text-align: center; width: 30px;">-</th>
                            <th>商品名称</th>
                            <th>商品类别</th>
                            <th>商品价格</th>
                            <th>商品库存</th>
                            <th>商家名称</th>
                            <th style="text-align: center; width: 200px;">商品描述</th>
                            <th style="text-align: center; width: 200px;">选择图片</th>
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
                        <tr class="good-row">
                            <td style="text-align: center; width: 30px;"><%= good.getId() %></td>
                            <td><input type="text" id="name_<%= good.getId() %>" value="<%= good.getGoodName() %>" class="common-text" /></td>
                            <td><input type="text" id="kind_<%= good.getId() %>" value="<%= good.getKind() %>" class="common-text" /></td>
                            <td><input type="text" id="price_<%= good.getId() %>" value="<%= good.getPrice() %>" class="common-text" /></td>
                            <td><input type="text" id="stock_<%= good.getId() %>" value="<%= good.getStock() %>" class="common-text" /></td>
                            <td><input type="text" value="<%= good.getMerchantName() %>" class="common-text" readonly /></td>
                            <td style="text-align: center; width: 200px;"><textarea id="description_<%= good.getId() %>" class="common-textarea"><%= good.getDescription() %></textarea></td>
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
