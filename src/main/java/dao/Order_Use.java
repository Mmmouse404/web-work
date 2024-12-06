package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

import static java.lang.System.getProperties;

public class Order_Use {
    // 查询订单
    public static ArrayList<Order> getOrders() throws SQLException {
        String sql = "SELECT * FROM orders";
        ArrayList<Order> arr = new ArrayList<>();
        Order ss;
        try {
            Connection con = UTIL.getCon();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet RS = ps.executeQuery();
            while (RS.next()) {
                ss = new Order();
                ss.setId(RS.getInt("ID"));
                ss.setGoodName(RS.getString("GOODNAME"));
                ss.setUserName(RS.getString("USERNAME"));
                ss.setAddress(RS.getString("ADDRESS"));
                ss.setNumber(RS.getInt("NUMBER"));
                ss.setPrice(RS.getString("PRICE"));
                ss.setmerchantname(RS.getString("MERCHANTNAME")); // 添加 merchantname 读取
                ss.setStatus(RS.getString("STATUS"));
                arr.add(ss);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arr;
    }


    public static int getGoodNumber() throws SQLException { // 获取订单数量
        String sql = "SELECT COUNT(*) FROM orders"; // 直接使用COUNT进行查询
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet RS = ps.executeQuery();
        int count = 0;
        if (RS.next()) {
            count = RS.getInt(1); // 获取结果集的第一列
        }
        return count;
    }

    public static void insertOrder(Order s) throws SQLException { // 增加订单
        // 先建立连接
        Connection con = UTIL.getCon();

        // 写在数据库中运行的 SQL
        String sql = "INSERT INTO orders (GOODNAME, USERNAME, ADDRESS, NUMBER, PRICE, MERCHANTNAME,STATUS) " +
                "VALUES (?, ?, ?, ?, ?, ?,?)"; // 添加 merchantname

        // 用占位符，准备执行
        PreparedStatement ps = con.prepareStatement(sql);

        // 设置占位符的值
        ps.setString(1, s.getGoodName());
        ps.setString(2, s.getUserName());
        ps.setString(3, s.getAddress());
        ps.setInt(4, s.getNumber());
        ps.setString(5, s.getPrice());
        ps.setString(6, s.getmerchantname()); // 新增merchantname设值
        ps.setString(7, s.getStatus());
        ps.executeUpdate(); // 返回操作记录数
    }
    // 按照商家获取订单
    public static ArrayList<Order> getOrdersByMerchant(String merchantName) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE MERCHANTNAME = ?"; // 根据商家名称查询订单
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantName); // 设置商家名称占位符
        ResultSet RS = ps.executeQuery();

        while (RS.next()) {
            Order order = new Order();
            order.setId(RS.getInt("ID"));
            order.setGoodName(RS.getString("GOODNAME"));
            order.setUserName(RS.getString("USERNAME"));
            order.setAddress(RS.getString("ADDRESS"));
            order.setNumber(RS.getInt("NUMBER"));
            order.setPrice(RS.getString("PRICE"));
            order.setmerchantname(RS.getString("MERCHANTNAME")); // 获取商家名称
            order.setStatus(RS.getString("STATUS"));
            orders.add(order); // 将订单加入列表
        }

        return orders; // 返回查询到的订单列表
    }
    // 按照商家获取订单
    public static ArrayList<Order> getOrdersByUsername(String userName) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE USERNAME = ?"; // 根据商家名称查询订单
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userName); // 设置商家名称占位符
        ResultSet RS = ps.executeQuery();

        while (RS.next()) {
            Order order = new Order();
            order.setId(RS.getInt("ID"));
            order.setGoodName(RS.getString("GOODNAME"));
            order.setUserName(RS.getString("USERNAME"));
            order.setAddress(RS.getString("ADDRESS"));
            order.setNumber(RS.getInt("NUMBER"));
            order.setPrice(RS.getString("PRICE"));
            order.setmerchantname(RS.getString("MERCHANTNAME")); // 获取商家名称
            order.setStatus(RS.getString("STATUS"));
            orders.add(order); // 将订单加入列表
        }

        return orders; // 返回查询到的订单列表
    }
    public static void deleteOrder(int orderId) throws SQLException {
        String sql = "DELETE FROM orders WHERE ID = ?";
        try (Connection con = UTIL.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId); // 设置要删除的订单 ID
            ps.executeUpdate(); // 执行删除操作
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // 抛出异常以便进一步处理
        }
    }
    public static void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET STATUS = ? WHERE ID = ?";
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status); // 更新状态为“已发货”
            ps.setInt(2, orderId); // 设置要更新的订单 ID
            ps.executeUpdate(); // 执行更新操作
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // 抛出异常以便进一步处理
        }
    }
    public static ArrayList<Order> getOrdersFiltered(String userName, String goodName, String address) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE USERNAME = ?");

        // 根据输入的条件动态构建查询
        if (goodName != null && !goodName.isEmpty()) {
            sql.append(" AND GOODNAME LIKE ?");
        }
        if (address != null && !address.isEmpty()) {
            sql.append(" AND ADDRESS LIKE ?");
        }

        try (Connection con = UTIL.getCon();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            ps.setString(1, userName); // 设置用户名称占位符

            // 设置商品名称和地址占位符
            int index = 2;
            if (goodName != null && !goodName.isEmpty()) {
                ps.setString(index++, "%" + goodName + "%");
            }
            if (address != null && !address.isEmpty()) {
                ps.setString(index++, "%" + address + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("ID"));
                order.setGoodName(rs.getString("GOODNAME"));
                order.setUserName(rs.getString("USERNAME"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setNumber(rs.getInt("NUMBER"));
                order.setPrice(rs.getString("PRICE"));
                order.setmerchantname(rs.getString("MERCHANTNAME")); // 获取商家名称
                order.setStatus(rs.getString("STATUS"));
                orders.add(order); // 将订单加入列表
            }
        }
        return orders;
    }
        public static void sendEmail(String to, String subject, String body) {
            // 设置邮件服务器的属性
            Properties properties = new Properties();
            properties.setProperty("mail.smtp.host", "smtp.163.com"); // SMTP 服务器地址
            properties.setProperty("mail.smtp.port", "465"); // SMTP 端口
            properties.setProperty("mail.smtp.auth", "true");
            properties.setProperty("mail.smtp.ssl.enable", "true"); // 确保启用 SSL
            properties.setProperty("mail.smtp.charset", "utf-8"); // SMTP 服务器地址
            properties.setProperty("mail.transport.protocol", "smtp");
            // 创建会话对象
            Session session = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("18126422610@163.com", "CHpm339qQrkr55CD"); // 发送邮箱和密码
                }
            });

            try {
                // 创建邮件消息
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress("18126422610@163.com")); // 发件人
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to)); // 收件人
                message.setSubject(subject); // 邮件主题
                message.setText(body); // 邮件内容
                Transport transport = session.getTransport();
                transport.connect("18126422610@163.com","CHpm339qQrkr55CD" );
                transport.sendMessage(message, new Address[]{new InternetAddress(to)});
                transport.close();
                // 发送邮件
//                Transport.send(message);
                System.out.println("邮件发送成功");
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
    public static void shipOrder(int orderId, String username) throws SQLException {


        // 更新订单状态为已发货
        updateOrderStatus(orderId, "已发货");

        // 获取用户的邮箱
        String email = User_Use.getUserEmail(username); // 根据用户名获取用户邮箱
        System.out.println("收件人邮箱：" + email);
        // 获取发货通知内容
        String subject = "您的订单已发货";
        String body = "尊敬的用户，您的订单（订单编号：" + orderId + "）已成功发货，感谢您的购买！"+"<br>商家名称：" + getOrderById(orderId).getmerchantname();

        // 发送邮件
        sendEmail(email, subject, body); // 调用发送邮件的功能
    }

    // 获取订单的方法示例
    private static Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE ID = ?";
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Order order = new Order();
            order.setId(rs.getInt("ID"));
            order.setGoodName(rs.getString("GOODNAME"));
            order.setUserName(rs.getString("USERNAME"));
            order.setAddress(rs.getString("ADDRESS"));
            order.setNumber(rs.getInt("NUMBER"));
            order.setPrice(rs.getString("PRICE"));
            order.setmerchantname(rs.getString("MERCHANTNAME"));
            order.setStatus(rs.getString("STATUS"));
            return order;
        }
        return null; // 订单未找到
    }


}
