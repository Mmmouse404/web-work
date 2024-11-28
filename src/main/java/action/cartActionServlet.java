package action;

import dao.Cart_Use;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cartAction")
public class cartActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // 获取请求动作
        String username = (String) request.getSession().getAttribute("upname"); // 获取当前用户

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id")); // 获取商品id
                Cart_Use.deleteCartItemById(id);
                response.getWriter().write("success"); // 返回成功消息
            } else if ("clear".equals(action)) {
                Cart_Use.clearCart(username);
                response.getWriter().write("success"); // 返回成功消息
            } else {
                response.getWriter().write("invalid action"); // 无效的操作
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("failed"); // 返回失败消息
        }
    }
}
