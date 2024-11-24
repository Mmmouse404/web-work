package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Merchant_Use {

    // 注册商家方法
    public static void register(String merchantName, String password) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "INSERT INTO merchants (merchantName, PASSWORD) VALUES (?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantName);
        ps.setString(2, password);
        ps.executeUpdate();
    }

    // 查询是否存在商家名称
    public static boolean checkMerchantByName(String merchantName) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE merchantName = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantName);
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

    // 登录验证
    public static boolean validateLogin(String merchantName, String password) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "SELECT * FROM merchants WHERE merchantName = ? AND PASSWORD = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, merchantName);
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
