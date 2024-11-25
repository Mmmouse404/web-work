<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>小卖部后台管理 - 设置</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function() {
                $(".sidebar-content>ul").toggle();
            });
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container clearfix">
    <jsp:include page="sidebar.jsp" />
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><a href="manageUser.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">系统设置</span></div>
        </div>
        <div class="result-wrap">
            <form action="#" method="post" id="myform" name="myform">
                <div class="config-items">
                    <div class="config-title">
                        <h1><i class="icon-font">&#xe00a;</i>网站信息设置</h1>
                    </div>
                    <div class="result-content">
                        <table width="100%" class="insert-tab">
                            <tbody>
                            <tr>
                                <th width="15%"><i class="require-red">*</i>域名：</th>
                                <td><input type="text" value="#" size="85" name="keywords" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>站点标题：</th>
                                <td><input type="text" value="小卖部" size="85" name="title" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>关键字：</th>
                                <td><input type="text" value="CSS, JavaScript, Ajax, Html5" size="85" name="keywords" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>描述：</th>
                                <td><input type="text" value="小卖部！" size="85" name="description" class="common-text"></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input type="submit" value="提交" class="btn btn-primary btn6 mr10">
                                    <input type="button" value="返回" onClick="history.go(-1)" class="btn btn6">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="config-items">
                    <div class="config-title">
                        <h1><i class="icon-font">&#xe014;</i>网站联系信息设置</h1>
                    </div>
                    <div class="result-content">
                        <table width="100%" class="insert-tab">
                            <tr>
                                <th width="15%"><i class="require-red">*</i>网站联系邮箱：</th>
                                <td><input type="text" size="85" name="email" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>联系人：</th>
                                <td><input type="text" size="85" name="contact" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>联系电话：</th>
                                <td><input type="text" size="85" name="phone" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>备案ICP：</th>
                                <td><input type="text" size="85" name="icp" class="common-text"></td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>地址：</th>
                                <td><input type="text" size="85" name="address" class="common-text"></td>
                            </tr>
                            <tr>
                                <th></th>
                                <td>
                                    <input type="submit" value="提交" class="btn btn-primary btn6 mr10">
                                    <input type="button" value="返回" class="btn btn6" onclick="history.go(-1)">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
