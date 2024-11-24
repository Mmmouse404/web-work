package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Order_Use {
    // 查询订单
    public static ArrayList<Order> getOrders() throws SQLException {
        String sql = "SELECT * FROM Orders";
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
                ss.setMerchantName(RS.getString("MERCHANTNAME")); // 添加 merchantName 读取
                arr.add(ss);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arr;
    }


    public static int getGoodNumber() throws SQLException { // 获取订单数量
        String sql = "SELECT COUNT(*) FROM Orders"; // 直接使用COUNT进行查询
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
        String sql = "INSERT INTO Orders (GOODNAME, USERNAME, ADDRESS, NUMBER, PRICE, MERCHANTNAME) " +
                "VALUES (?, ?, ?, ?, ?, ?)"; // 添加 merchantName

        // 用占位符，准备执行
        PreparedStatement ps = con.prepareStatement(sql);

        // 设置占位符的值
        ps.setString(1, s.getGoodName());
        ps.setString(2, s.getUserName());
        ps.setString(3, s.getAddress());
        ps.setInt(4, s.getNumber());
        ps.setString(5, s.getPrice());
        ps.setString(6, s.getMerchantName()); // 新增merchantName设值

        ps.executeUpdate(); // 返回操作记录数
    }
}
