package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Merchant_Use {

    // 注册商家方法
    public static void register(String merchantid,String merchantname, String password) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "INSERT INTO merchants (ID,merchantname, PASSWORD) VALUES (?,?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantid);
        ps.setString(2, merchantname);
        ps.setString(3, password);
        ps.executeUpdate();
    }

    // 查询是否存在商家名称
    public static boolean checkMerchantByName(String merchantname) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE merchantname = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantname);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // 如果找到记录，则存在
    }

    // 根据商家ID查询商家
    public static boolean checkMerchantById(String id) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // 如果找到记录，则存在
    }
    // 根据商家ID查询商家
    public static boolean selectId(String id) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE ID = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // 如果找到记录，则存在
    }
    public static String returnname(String id) throws SQLException {   //根据id找账号名
        Connection con = UTIL.getCon();
        String sql = "select * from merchants where ID=" + id;
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs4 = pstmt.executeQuery();
        String name = null;
        while (rs4.next()) {//指针向后移动
            name = rs4.getString("merchantname");
        }
        return name;
    }
    // 登录验证
    public static boolean validateLogin(String merchantname, String password) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE merchantname = ? AND PASSWORD = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantname);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // 如果找到记录，则验证成功
    }
    public static boolean validateLoginById(String merchantID, String password) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE ID = ? AND PASSWORD = ?"; // 根据 ID 验证
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantID);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        return rs.next(); // 如果找到记录，则验证成功
    }

}
