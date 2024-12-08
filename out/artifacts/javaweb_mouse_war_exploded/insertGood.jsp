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
            })


        });
        function insertshop() {
            var i1=$("#i1").val();
            var i2=$("#i2").val();
            var i3=$("#i3").val();
            var i4=$("#i4").val();
            var i5=$("#i5").val();
            var i6=$("#i6").val();
            var param="id="+i1+"&image="+i2+"&kind="+i3+"&name="+i4+"&price="+i5+"&stock="+i6;
            sendRequest("ishop",param,"POST",result);
        }
        function result(){
            if (httpRequest.readyState == 4) {
                if (httpRequest.status == 200) {
                    alert("商品上架成功！");
                }
            }

        }

    </script>
</head>
<body>
<div class="topbar-wrap white">
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix">
            <h1 class="topbar-logo none"><a href="manager/index.html" class="navbar-brand">后台管理</a></h1>
            <ul class="navbar-list clearfix">
                <li><a class="on" href="manageByUser.jsp">首页</a></li>
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
                        <li><a href="manageByUser.jsp">用户信息</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">商品管理</a>
                    <ul class="sub-menu">
                        <li><a href="showGood.jsp">全部商品</a></li>
                        <li><a href="#">添加商品</a></li>
                        <li><a href="showGood.jsp">删除商品</a></li>
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
            <div class="crumb-list"><a href="manager/index.html">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">新增商品</span></div>
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
                                <td><input type="text" id="i1" value="" size="85" name="" class="common-text" placeholder="例：1007"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>图片路径：</th>
                                <td><input type="text" id="i2" value="" size="85" name="" class="common-text" placeholder="例：shoimg/10007.jpg"></td>
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
                                    <input type="submit" value="上架" class="btn btn-primary btn6 mr10" onclick="insertshop()">
                                    <input type="button" value="返回" onClick="" class="btn btn6">
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
