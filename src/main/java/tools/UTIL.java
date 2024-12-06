package tools;

// 数据库有关的包
import dao.Goodlist_Use;
import dao.Order;

import java.sql.*;
import java.util.ArrayList;

public class UTIL {
    public static Connection getCon() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // 更改为 MySQL 驱动类
            try {
                con = DriverManager.getConnection(
                        "jdbc:mysql://8.134.196.79:3306/shop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", // 更改为 MySQL URL
                        "user01", // 替换为你的 MySQL 用户名
                        "Heavenhhz520" // 替换为你的 MySQL 密码
                );
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) throws SQLException {
        Connection con=UTIL.getCon();
        String sql="select * from users";
        PreparedStatement gg=con.prepareStatement(sql);
        ResultSet rs1=gg.executeQuery();
        ArrayList<String> arr = new ArrayList<>();
        try{
            while(rs1.next()){//指针向后移动
                String nname=rs1.getString("NAME");
                arr.add(nname);
            }
            System.out.println(arr);
        }catch(Exception e){
            e.printStackTrace();
        }
        System.out.println(Goodlist_Use.getGoodList().get(0).getGoodName());
    }
}
