package action;

import dao.Order;
import dao.Order_Use;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/iindent")
public class addOrderServlet extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setContentType("text/html;charset=utf-8");

        String itemsJson = req.getParameter("items"); // 获取商品信息
        JSONArray itemsArray = new JSONArray(itemsJson); // 解析为JSON数组

        String username = (String) req.getSession().getAttribute("upname");

        try {
            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject itemObj = itemsArray.getJSONObject(i);
                String goodname = itemObj.getString("goodname");
                int number = itemObj.getInt("number");
                String price = itemObj.getString("price");
                String address = itemObj.getString("address"); // 同时可以从请求中获取用户地址
                String merchantname = itemObj.getString("merchantname");
                Order order = new Order();
                order.setGoodName(goodname);
                order.setUserName(username);
                order.setAddress(address);
                order.setNumber(number);
                order.setPrice(price);
                order.setmerchantname(merchantname);
                Order_Use.insertOrder(order);   // 插入订单处理
            }
            res.getWriter().write("订单创建成功！"); // 发送成功消息
        } catch (SQLException | JSONException e) {
            e.printStackTrace();
            res.getWriter().write("订单创建失败！"); // 发送失败消息
        }
    }
}
