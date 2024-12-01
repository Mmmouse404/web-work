package action;

import dao.User_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/increaseMoney") // Servlet 的 URL 映射
public class increaseMoneyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username"); // 获取用户名
        String amountParam = request.getParameter("amount"); // 获取增加金额

        if (username != null && amountParam != null) {
            try {
                double amount = Double.parseDouble(amountParam); // 转换为 double 类型
                if (amount > 0 && amount <= 1999) {
                    // 调用 User_Use 方法增加用户金额
                    User_Use.incrementUserMoney(username, amount);
                    response.getWriter().write("success"); // 返回成功响应
                } else {
                    response.getWriter().write("invalid amount"); // 返回无效金额的响应
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("error"); // 返回错误响应
            }
        } else {
            response.getWriter().write("invalid request"); // 返回无效请求的响应
        }
    }
}
