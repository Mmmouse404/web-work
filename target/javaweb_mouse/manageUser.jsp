<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.User" %>
<%@ page import="dao.User_Use" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // 检查管理员密码的 Session
    boolean isAdminLoggedIn = (session.getAttribute("isAdminLogged")!=null);
%>
<html>
<head>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
    <script src="js/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#passwordModal").fadeIn(); // 显示管理员密码模态框
        });
        function closeModal() {
            $("#passwordModal").fadeOut();
            $("#overlay").hide(); // 隐藏背景遮罩
            if (!<%= isAdminLoggedIn %>) {
                window.location.href = "manageGood.jsp";
            }
        }
        function closeregisterModal() {
            $("#registrationModal").hide(); // 隐藏主要内容
            $("#overlay").hide(); // 隐藏背景遮罩
        }
        function submitPassword() {
            var password = $("#adminPassword").val();
            if (password === "root") {
                // 发送请求设置 Session，在后端处理
                $.post("setSession", {}, function(response) {
                    if (response === "success") {
                        alert("管理员密码正确，正在跳转...");
                        // 如果设置成功，刷新页面
                        location.reload();
                    }
                });
            } else {
                alert("密码错误，请重试");
            }
        }


        function submitRegistration() {
            var loginname = $("#regUsername").val();
            var loginid = $("#regUserId").val();
            var loginpass = $("#regPassword").val();

            if (loginname && loginid && loginpass) {
                $.post("loginwin", { loginname: loginname, loginid: loginid, loginpass: loginpass }, function(response) {
                    alert(response);
                    location.reload(); // 刷新页面
                });
            } else {
                alert("请填写所有字段！");
            }
        }

        function deleteUsers() {
            var ids = [];
            $("input[name='checkbox']:checked").each(function() {
                ids.push($(this).val());
            });

            if (ids.length > 0) {
                if (confirm("确认要删除所选用户吗？")) {
                    $.ajax({
                        url: "userBatchDelete",
                        type: "POST",
                        data: { ids: ids }, // 按传统格式传递数组
                        traditional: true, // 允许传统方式处理数组
                        success: function(response) {
                            alert("删除成功");
                            location.reload(); // 刷新页面
                        },
                        error: function() {
                            alert("删除失败，请重试");
                        }
                    });
                }
            } else {
                alert("请至少选择一个用户删除");
            }
        }

        $(function () {
            $(".sidebar-content>ul>li").click(function() {
                $(this).children('ul').toggle();
            });
            $(".sidebar-title").click(function () {
                $(".sidebar-content>ul").toggle();
            });
        });
    </script>
    <style>
        /* 模态框样式 */
        #passwordModal {
            display: none; /* 默认隐藏 */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
            z-index: 1000;
            text-align: center;
        }
        #overlay {
            display: block; /* 默认显示 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5); /* 半透明背景 */
            z-index: 999;
        }
        #registrationModal {
            display: none; /* 默认隐藏 */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
            z-index: 1000;
            text-align: center;
        }
        .button-container {
            margin: 10px 0; /* 设置上下间距 */
        }
    </style>
</head>

<body>

<!-- 背景遮罩 -->
<div id="overlay" <% if (isAdminLoggedIn) { %>style="display: none;"<% } %>></div>

<!-- 管理员密码模态框 -->
<div id="passwordModal" <% if (isAdminLoggedIn) { %>style="display: none;"<% } %>>
    <h3>请输入管理员密码(如登录成功，关闭即可)</h3>
    <input type="password" id="adminPassword" placeholder="密码" />
    <br>
    <button onclick="submitPassword()">提交</button>
    <button onclick="closeModal()">关闭</button>
</div>

<!-- 用户注册模态框 -->
<div id="registrationModal">
    <h3>新增用户</h3>
    <input type="text" id="regUsername" placeholder="用户名" required />
    <input type="text" id="regUserId" placeholder="账号" required />
    <input type="password" id="regPassword" placeholder="密码" required />
    <br>
    <button onclick="submitRegistration()">提交</button>
    <button onclick="closeregisterModal()">关闭</button>
</div>

<div id="mainContent" style="display:<%= isAdminLoggedIn ? "block" : "none" %>;">
    <jsp:include page="header.jsp" />

    <div class="container clearfix">
        <jsp:include page="sidebar.jsp" />

        <div class="main-wrap">
            <div class="crumb-wrap">
                <div class="crumb-list"><a href="manageGood.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">用户信息</span></div>
            </div>

            <div class="result-wrap">
                <div class="result-title">
                    <div class="result-list">
                        <!-- 将批量删除和新增用户按钮放在同一栏 -->
                        <div class="button-container">
                            <a herf="batchDel" onclick="deleteUsers()">批量删除</a>
                            <a href="javascript:void(0);" onclick="$('#registrationModal').fadeIn();">新增用户</a>
                        </div>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width="100%">
                        <tr>
                            <th class="tc" width="5%"><input class="allChoose" type="checkbox" id="c1" name="checkbox">全选</th>
                            <th>用户名</th>
                            <th>账号</th>
                            <th>密码</th>
                        </tr>
                        <%
                            ArrayList<User> arr = User_Use.getListWithVOFromRS();
                            int num = User_Use.getUsernumber();
                            for (User uu : arr) {
                        %>
                        <tr>
                            <td class="tc"><input name="checkbox" value="<%= uu.getId() %>" type="checkbox"></td>
                            <td><%= uu.getName() %></td>
                            <td><%= uu.getId() %></td>
                            <td><%= uu.getPassword() %></td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="list-page"> 总计<%= num %> 条 1/1 页</div>
                </div>
            </div>
        </div>
        <!--/main-->
    </div>
</div>

</body>
</html>
