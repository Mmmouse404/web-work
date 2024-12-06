package action;

import dao.Order_Use;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/shipOrder")
public class shipOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        String username = request.getParameter("username");
        try {
            Order_Use.updateOrderStatus(orderId, status); // 更新订单状态为“已发货”
            if (status.equals("已发货")) {
                Order_Use.shipOrder(orderId, username);
            }
            response.getWriter().write("success"); // 返回成功信息
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error"); // 返回错误信息
        }
    }
}
