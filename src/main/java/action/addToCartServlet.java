package action;

import dao.Cart_Use;
import dao.Cart; // 购物车数据对象
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addToCart")
public class addToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String goodName = request.getParameter("goodname");
        String username = request.getParameter("username");
        String address = request.getParameter("address");
        String numberStr = request.getParameter("number");
        String price = request.getParameter("price");
        String merchantname = request.getParameter("merchantname");

        int number;
        try {
            number = Integer.parseInt(numberStr);
            if (number <= 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("数量必须大于0");
                return;
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("数量格式不正确");
            return;
        }

        // 创建一个 Cart 对象
        Cart cartItem = new Cart();
        cartItem.setGoodName(goodName);
        cartItem.setUserName(username);
        cartItem.setAddress(address);
        cartItem.setNumber(number);
        cartItem.setPrice(price);
        cartItem.setmerchantname(merchantname); // Set merchantname

        try {
            Cart_Use.addToCart(cartItem); // 将商品添加到购物车
            response.setStatus(HttpServletResponse.SC_OK); // 设置响应状态为成功
            response.getWriter().write("成功加入购物车！"); // 发送成功消息
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 设置为500错误
            response.getWriter().write("数据库异常，加入购物车失败");
        }
    }
}
