package action;

import dao.Order;
import dao.Order_Use;
import dao.Goodlist_Use; // 引入 Goodlist_Use 以检查库存
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.User_Use;
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
            double totalCost = 0; // 用于计算订单总成本

            // 遍历选中的商品，计算总成本并检查库存
            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject itemObj = itemsArray.getJSONObject(i);
                String goodname = itemObj.getString("goodname");
                int number = itemObj.getInt("number");
                String price = itemObj.getString("price");

                // 计算每个商品的成本
                totalCost += number * Double.parseDouble(price);

                // 库存检查逻辑
                boolean isInStock = Goodlist_Use.checkStock(goodname, number);
                if (!isInStock) {
                    res.getWriter().write("库存不足");
                    return; // 返回库存不足的消息
                }
            }

            // 检查用户余额
            double userMoney = User_Use.getUserMoney(username);
            if (userMoney < totalCost) {
                res.getWriter().write("余额不足");
                return; // 返回余额不足的消息
            }

            // 如果库存充足且余额足够，则创建并插入订单
            for (int i = 0; i < itemsArray.length(); i++) {
                JSONObject itemObj = itemsArray.getJSONObject(i);
                String goodname = itemObj.getString("goodname");
                int number = itemObj.getInt("number");
                String address = itemObj.getString("address");
                String merchantname = itemObj.getString("merchantname");
                String price = itemObj.getString("price");
                // 创建订单对象
                Order order = new Order();
                order.setGoodName(goodname);
                order.setUserName(username);
                order.setAddress(address);
                order.setNumber(number);
                order.setPrice(price);
                order.setmerchantname(merchantname);

                Order_Use.insertOrder(order); // 插入订单处理
                Goodlist_Use.updateStock(goodname, number); // 更新库存
            }

            // 扣除用户余额
            User_Use.updateUserMoney(username, userMoney - totalCost); // 更新用户余额
            res.getWriter().write("订单创建成功！"); // 发送成功消息
        } catch (SQLException | JSONException e) {
            e.printStackTrace();
            res.getWriter().write("订单创建失败！"); // 发送失败消息
        }
    }
}

