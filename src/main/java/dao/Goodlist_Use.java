package dao;

import tools.UTIL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class Goodlist_Use {
    public static ArrayList<Goodlist> getGoodList() throws SQLException{    //查询全部商品
        String sql = "select * from Goodlists";
        ArrayList<Goodlist> arr = new ArrayList<>();
        Goodlist gs = null;
        try {
            Connection con = UTIL.getCon();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet RS = ps.executeQuery();
            while (RS.next()) {
                gs = new Goodlist();
                gs.setId(RS.getString("id"));
                gs.setGoodName(RS.getString("goodname"));
                gs.setImage(RS.getString("image"));
                gs.setPrice(RS.getString("price"));
                gs.setStock(RS.getString("stock"));
                gs.setKind(RS.getString("kind"));
                gs.setMerchantName(RS.getString("merchantname"));
                arr.add(gs);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return arr;
    }
    public static ArrayList<Goodlist> getGoodListByKind(String category, String keywords) throws SQLException {
        ArrayList<Goodlist> arr = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Goodlists WHERE 1=1"); // 创建基础查询

        // 根据类别添加条件
        if (category != null && !category.isEmpty()) {
            sql.append(" AND kind = ?");
        }
        // 根据关键字添加条件
        if (keywords != null && !keywords.isEmpty()) {
            sql.append(" AND goodname LIKE ?");
        }

        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // 设置类别参数
            if (category != null && !category.isEmpty()) {
                ps.setString(paramIndex++, category);
            }
            // 设置关键词参数
            if (keywords != null && !keywords.isEmpty()) {
                ps.setString(paramIndex++, "%" + keywords + "%"); // 使用模糊查询
            }

            ResultSet RS = ps.executeQuery();
            while (RS.next()) {
                Goodlist gs = new Goodlist();
                gs.setId(RS.getString("id"));
                gs.setGoodName(RS.getString("goodname"));
                gs.setImage(RS.getString("image"));
                gs.setPrice(RS.getString("price"));
                gs.setStock(RS.getString("stock"));
                gs.setKind(RS.getString("kind"));
                gs.setMerchantName(RS.getString("merchantname"));
                arr.add(gs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arr;
    }
    public static int getGoodNumber() throws SQLException {           //得到商品数量
        String sql = "select * from Goodlists";
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet RS=ps.executeQuery();
        int count=0;
        while(RS.next())
        {
            count=count+1;
        }
        return count;
    }
    public static ArrayList<String> getAllKinds() throws SQLException {
        ArrayList<String> kinds = new ArrayList<>();
        String sql = "SELECT DISTINCT kind FROM Goodlists"; // 获取不同的商品分类
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet RS = ps.executeQuery();
            while (RS.next()) {
                kinds.add(RS.getString("kind")); // 将获得的分类添加到列表中
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kinds;
    }
    public  static String searchNameById(String id) throws SQLException{  //根据id查商品名字
        String sql = "select goodname from Goodlists where id="+id;
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet RS=ps.executeQuery();
        String goodname=null;
        while (RS.next()){
            goodname=RS.getString("goodname");
        }
        return goodname;
    }
    public  static String searchPriceById(String id) throws SQLException{  //根据id查商品价格
        String sql = "select price from Goodlists where id="+id;
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet RS=ps.executeQuery();
        String price=null;
        while (RS.next()){
            price=RS.getString("price");
        }
        return price;
    }
    public  static String searchImageByName(String goodname) throws SQLException{  //根据id查商品图片
        String sql = "select image from Goodlists where goodname=?";
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, goodname); // 设置查询参数
        ResultSet RS=ps.executeQuery();
        String image=null;
        while (RS.next()){
            image=RS.getString("image");
        }
        return image;
    }
    public  static String searchmerchantnameById(String id) throws SQLException{  //根据id查商品图片
        String sql = "select merchantname from Goodlists where id="+id;
        Connection con = UTIL.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet RS=ps.executeQuery();
        String merchantname=null;
        while (RS.next()){
            merchantname=RS.getString("merchantname");
        }
        return merchantname;
    }
    public static Goodlist searchGoodById(String id) throws SQLException {
        String sql = "SELECT * FROM Goodlists WHERE id = ?";
        Goodlist good = null;

        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id); // 设置查询参数

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                good = new Goodlist();
                good.setId(rs.getString("id")); //设置商品ID
                good.setGoodName(rs.getString("goodname")); // 设置商品名称
                good.setImage(rs.getString("image")); // 设置商品图片
                good.setPrice(rs.getString("price")); // 设置商品价格
                good.setStock(rs.getString("stock")); // 设置库存数量
                good.setKind(rs.getString("kind")); // 设置商品类别
                good.setMerchantName(rs.getString("merchantname")); // 设置商家名称
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // 抛出异常以便进一步处理
        }

        return good; // 返回商品对象
    }
    public static void insertGood(Goodlist s) throws SQLException, ClassNotFoundException {   //增加商品
        //先建立 连接
        Connection con=UTIL.getCon();//
        //写在数据库中运行的 sql  insert ... 对于java代码来说，其实就是一个字符串
        String sql="insert into Goodlists (goodname,kind,image,price,stock,merchantname)  " +
                "values (?,?,?,?,?,?) ";
        //用占位符 每个?是一个占位符,等下会传入的值
        PreparedStatement ps=con.prepareStatement(sql);
        //第一个?就是序号1
        ps.setString(1,s.getGoodName());
        ps.setString(2,s.getKind());
        ps.setString(3,s.getImage());
        ps.setString(4,s.getPrice());
        ps.setString(5,s.getStock());
        ps.setString(6,s.getMerchantName());
        int m= ps.executeUpdate();// 返回类型是操作记录数
        System.out.println(m);
    }
    public static void deleteGood(String id) throws SQLException {
        String sql = "DELETE FROM Goodlists WHERE id = ?";
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate(); // 执行删除操作
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static ArrayList<Goodlist> getGoodsByMerchantName(String merchantName) throws SQLException {
        ArrayList<Goodlist> arr = new ArrayList<>();
        String sql = "SELECT * FROM Goodlists WHERE merchantname = ?"; // 根据商家名称过滤

        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, merchantName); // 设置查询参数
            ResultSet RS = ps.executeQuery();

            while (RS.next()) {
                Goodlist gs = new Goodlist();
                gs.setId(RS.getString("id"));
                gs.setGoodName(RS.getString("goodname"));
                gs.setImage(RS.getString("image"));
                gs.setPrice(RS.getString("price"));
                gs.setStock(RS.getString("stock"));
                gs.setKind(RS.getString("kind"));
                gs.setMerchantName(RS.getString("merchantname"));
                arr.add(gs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arr; // 返回该商家的商品列表
    }
    public static boolean checkStock(String goodname, int quantity) throws SQLException {
        String sql = "SELECT stock FROM Goodlists WHERE goodname = ?";
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, goodname);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int stock = rs.getInt("stock");
                return stock >= quantity; // 检查库存是否充足
            }
        }
        return false; // 如果没有找到相应的商品
    }
    public static void updateGood(Goodlist good) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Goodlists SET goodname = ?, kind = ?, image = ?, price = ?, stock = ? WHERE id = ?";
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, good.getGoodName());
            ps.setString(2, good.getKind());
            ps.setString(3, good.getImage());
            ps.setString(4, good.getPrice());
            ps.setString(5, good.getStock());
            ps.setString(6, good.getId());
            ps.executeUpdate(); // 执行更新操作
        }
    }
    public static void updateStock(String goodname, int quantity) throws SQLException {
        String sql = "UPDATE Goodlists SET stock = stock - ? WHERE goodname = ?";
        try (Connection con = UTIL.getCon(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity); // 减去的数量
            ps.setString(2, goodname); // 设置商品ID
            ps.executeUpdate(); // 执行更新操作
        }
    }

}
