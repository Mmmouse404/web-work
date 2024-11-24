<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>小卖部后台管理增加商品</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/ajax.js"></script>
    <script>
        $(function () {
            //下拉菜单栏的实现 toggle():切换隐藏显示状态
            $(".sidebar-content>ul>li").click(function(){
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
            });
        });

        function insertGood() {
            var formData = new FormData(); // 创建FormData对象
            var i1=$("#i1").val();
            var i2 = document.getElementById('i2').files[0]; // 获取文件对象
            var i3=$("#i3").val();
            var i4=$("#i4").val();
            var i5=$("#i5").val();
            var i6=$("#i6").val();
            formData.append("id", i1);
            formData.append("image", i2); // 直接使用文件对象
            formData.append("kind", i3);
            formData.append("goodname", i4);
            formData.append("price", i5);
            formData.append("stock", i6);

            // 发送AJAX请求
            $.ajax({
                url: "ishop", // 上传处理的服务器端URL
                type: "POST",
                data: formData,
                processData: false, // 不处理数据
                contentType: false, // 不设置内容类型
                success: function(response) {
                    alert("商品上架成功！"); // 提示用户商品已上架
                    location.reload(); // 刷新当前页面
                },
                error: function(xhr, status, error) {
                    alert("上传失败，请重试。"); // 错误提示
                }
            });
        }

        function result(){
            if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) {
                    alert("商品上架成功！");
                }
            }
        }

        function previewImage(event) {
            var image = document.getElementById('imagePreview');
            var file = event.target.files[0];

            if (file) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    image.src = e.target.result; // 设置预览图像的源
                    image.style.display = 'block'; // 显示预览图像
                }

                reader.readAsDataURL(file); // 将文件读取为Data URL
            } else {
                image.src = ""; // 如果没有选择图片，清空预览
                image.style.display = 'none'; // 隐藏预览图像
            }
        }

    </script>
</head>
<body>
<div class="topbar-wrap white">
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix">
            <h1 class="topbar-logo none"><a href="manageUser.jsp" class="navbar-brand">后台管理</a></h1>
            <ul class="navbar-list clearfix">
                <li><a class="on" href="manageUser.jsp">首页</a></li>
                <li><a href="user.jsp" target="_blank">小卖部用户登录</a></li>
            </ul>
        </div>
        <div class="top-info-wrap">
            <ul class="top-info-list clearfix">
                <li><a href="#">管理员</a></li>
                <li><a href="#">店长信息</a></li>
                <li><a href="#">退出</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="container clearfix">
    <div class="sidebar-wrap">
        <div class="sidebar-title">
            <a href="#"><h1>菜单</h1></a>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-list">
                <li>
                    <a href="#">用户管理</a>
                    <ul class="sub-menu">
                        <li><a href="manageUser.jsp">用户信息</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">商品管理</a>
                    <ul class="sub-menu">
                        <li><a href="manageGood.jsp">全部商品</a></li>
                        <li><a href="#">添加商品</a></li>
                        <li><a href="manageGood.jsp">删除商品</a></li>
                        <li><a href="manageOrder.jsp">商品订单</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">系统管理</a>
                    <ul class="sub-menu">
                        <li><a href="manageSetting.jsp">系统设置</a></li>
                        <li><a href="manageSetting.jsp">清理缓存</a></li>
                        <li><a href="manageSetting.jsp">数据备份</a></li>
                        <li><a href="manageSetting.jsp">数据还原</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><a href="managerUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">新增商品</span></div>
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
                                <td><input type="text" id="i3" value="" size="85" name="" class="common-text" placeholder="例：饮料"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品名称：</th>
                                <td><input type="text" id="i4" value="" size="85" name="" class="common-text" placeholder="例：百事可乐"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品价格：</th>
                                <td><input type="text" id="i5" value="" size="85" name="" class="common-text" placeholder="例：4.0"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>商品库存：</th>
                                <td><input type="text" id="i6" value="" size="85" name="" class="common-text" placeholder="例：66"></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input type="submit" value="上架" class="btn btn-primary btn6 mr10" onclick="insertGood(); return false;">
                                    <input type="button" value="返回" onClick="window.location.href='manageGood.jsp';" class="btn btn6">
                                </td>
                            </tr>
                            </tbody></table>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>
