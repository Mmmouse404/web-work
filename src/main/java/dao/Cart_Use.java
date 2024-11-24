package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Cart_Use {

    // 增加商品到购物车
    public static void addToCart(Cart cartItem) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "INSERT INTO Cart (goodname, username, address, number, price, merchantname) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, cartItem.getGoodName());
        ps.setString(2, cartItem.getUserName());
        ps.setString(3, cartItem.getAddress());
        ps.setInt(4, cartItem.getNumber());
        ps.setString(5, cartItem.getPrice());
        ps.setString(6, cartItem.getMerchantName());
        ps.executeUpdate();
    }

    // 获取用户的购物车商品
    public static ArrayList<Cart> getCartItems(String username) throws SQLException {
        ArrayList<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE username = ?";
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Cart item = new Cart();
            item.setGoodName(rs.getString("goodname"));
            item.setUserName(rs.getString("username"));
            item.setAddress(rs.getString("address"));
            item.setNumber(rs.getInt("number"));
            item.setPrice(rs.getString("price"));
            item.setMerchantName(rs.getString("merchantname")); // 新增获取商家名称
            cartItems.add(item);
        }
        return cartItems;
    }

    public static void deleteCartItem(String username, String goodName) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "DELETE FROM Cart WHERE username = ? AND goodname = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, goodName);
        ps.executeUpdate();
    }

    public static void clearCart(String username) throws SQLException {
        Connection con = UTIL.getCon();
        String sql = "DELETE FROM Cart WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ps.executeUpdate();
    }

}
