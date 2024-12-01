<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.User_Use" %>
<%@ page import="java.sql.SQLException" %>
<%
    // 检查用户是否已登录
    String username = (String) session.getAttribute("upname");
    double userMoney = 0.0;

    // 如果用户已登录，获取用户的金额
    if (username != null) {
        try {
            userMoney = User_Use.getUserMoney(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    } else {
        out.println("<p>请先登录以增加金额。</p>");
    }
%>

<div id="increaseMoneyDialog" style="display: none;">
    <h3>增加金额</h3>

    <!-- 输入框和滑动条 -->
    <input type="number" id="amountToAdd" min="0" max="1999" value="0" placeholder="增加金额（0-1999）" style="width: 100%; margin-bottom: 10px;"
           oninput="updateSlider()">
    <input type="range" id="amountSlider" min="0" max="1999" value="0" style="width: 100%;"
           onchange="updateInput()">
    <button onclick="submitIncreaseMoney()">提交</button>
    <span id="increaseMessage"></span>
</div>

<script>
    // 拖动功能
    var dialog = document.getElementById("increaseMoneyDialog");
    var isDragging = false; // 标识是否正在拖动
    var startX, startY; // 鼠标起始位置

    dialog.onmousedown = function(event) {
        isDragging = true; // 开始拖动
        startX = event.clientX;
        startY = event.clientY;

        // 阻止对于其他元素的默认行为
        event.preventDefault(); // 禁止选中
    };

    document.onmousemove = function(event) {
        if (isDragging) {
            dialog.style.left = (dialog.offsetLeft + (event.clientX - startX)) + 'px';
            dialog.style.top = (dialog.offsetTop + (event.clientY - startY)) + 'px';
            startX = event.clientX;
            startY = event.clientY;
        }
    };

    document.onmouseup = function() {
        isDragging = false; // 停止拖动
    };

    // 允许滑动条事件传递
    document.getElementById("amountSlider").onmousedown = function(event) {
        event.stopPropagation(); // 阻止事件冒泡
    };

    // 更新滑动条和输入框同步
    function updateSlider() {
        var inputVal = document.getElementById("amountToAdd").value;
        document.getElementById("amountSlider").value = inputVal;
    }

    function updateInput() {
        var sliderVal = document.getElementById("amountSlider").value;
        document.getElementById("amountToAdd").value = sliderVal;
    }

    function submitIncreaseMoney() {
        var amountToAdd = parseFloat(document.getElementById("amountToAdd").value);
        var username = "<%= username %>"; // 获取当前用户名

        if (username && !isNaN(amountToAdd) && amountToAdd >= 0 && amountToAdd <= 1999) {
            $.ajax({
                url: "increaseMoney", // 后端处理的URL
                type: "POST",
                data: { username: username, amount: amountToAdd },
                success: function(response) {
                    if (response.trim() === "success") {
                        document.getElementById("increaseMessage").innerText = "金额已成功增加！";
                        location.reload(); // 刷新页面以更新金额显示
                    } else {
                        document.getElementById("increaseMessage").innerText = "增加金额失败，请重试。";
                    }
                },
                error: function() {
                    document.getElementById("increaseMessage").innerText = "请求失败，请重试。";
                }
            });
        } else {
            alert("请输入有效的金额（0-1999）。");
        }
    }
</script>
