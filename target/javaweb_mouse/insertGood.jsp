<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.Goodlist" %>
<%@ page import="dao.Goodlist_Use" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.http.Part" %>
<html>
<head>
    <title>小卖部后台管理增加商品</title>
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

        function insertGood() {
            var formData = new FormData();
            var goodImage = document.getElementById('i2').files[0];
            var goodKind = $("#i3").val();
            var goodName = $("#i4").val();
            var goodPrice = $("#i5").val();
            var goodStock = $("#i6").val();
            var description = $("#i7").val();
            var merchantName = "<%= session.getAttribute("merchantname") %>";

            formData.append("image", goodImage);
            formData.append("kind", goodKind);
            formData.append("goodname", goodName);
            formData.append("price", goodPrice);
            formData.append("stock", goodStock);
            formData.append("description", description);
            formData.append("merchantname", merchantName);

            $.ajax({
                url: "ishop",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert("商品上架成功！" + response);
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert("上传失败，请重试：", error);
                }
            });
        }

        function previewImage(event) {
            var imagePreview = document.getElementById('imagePreview');
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
            <div class="crumb-list"><a href="manageGood.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">新增商品</span></div>
        </div>
        <div class="result-wrap">
            <form action="#" method="post" id="myform" name="myform">
                <div class="config-items">
                    <div class="config-title">
                        <h1><i class="icon-font">&#xe00a;</i>小卖部上架商品</h1>
                    </div>
                    <div class="result-content">
                        <table width="100%" class="insert-tab">
                            <tbody>
                            <tr>
                                <th width="15%"><i class="require-red">*</i>商品编号：</th>
                                <td><input type="text" id="i1" value="" size="85" name="" class="common-text" placeholder="自动生成" disabled></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>选择图片：</th>
                                <td>
                                    <input type="file" id="i2" class="common-text" accept="image/*" onchange="previewImage(event)">
                                    <br>
                                    <img id="imagePreview" src="" alt="图片预览" style="display:none; max-width:200px; max-height:200px; margin-top:10px;">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品类别：</th>
                                <td><input type="text" id="i3" size="85" name="" class="common-text" placeholder="例：饮料"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品名称：</th>
                                <td><input type="text" id="i4" size="85" name="" class="common-text" placeholder="例：百事可乐"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品价格：</th>
                                <td><input type="text" id="i5" size="85" name="" class="common-text" placeholder="例：4.0"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品库存：</th>
                                <td><input type="text" id="i6" size="85" name="" class="common-text" placeholder="例：66"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商家名称：</th>
                                <td><input type="text" id="merchantname" value="<%= session.getAttribute("merchantname") %>" size="85" class="common-text" readonly></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品描述：</th>
                                <td><input type="text" id="i7" size="85" name="" class="common-text" placeholder="例：这是一个很便宜的产品"></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input type="submit" value="上架" class="btn btn-primary btn6 mr10" onclick="insertGood(); return false;">
                                    <input type="button" value="返回" onClick="window.location.href='manageGood.jsp';" class="btn btn6">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
